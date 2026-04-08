Execute the agent daily cycle.

This is an on-demand run. Skip the idempotency gate (don't check for existing daily report).

## Step 1 — Load configuration

Read `source/stream-mapping.yaml` for project IDs, state mapping, and context file mappings.

## Step 2 — Scan all projects

For each mapped project, fetch open issues in "Todo"/"Now" state via task manager MCP.
Skip issues that are:
- Completed
- Labeled `human-only`
- Labeled `agent-pending` (already has open proposal)

## Step 3 — Execute approved issues FIRST

Find issues labeled `agent-approved`. These already have a prior proposal that was approved.
For each:
1. Load context files for the issue's spring
2. Execute the approved work
3. Post results as a comment on the issue
4. Re-label as `agent-pending` so the human can verify output

Process ALL approved issues before moving to classification.

## Step 4 — Classify remaining issues

For each unlabeled issue, determine:
- **Spring** (from project mapping)
- **What the agent can do** — research, draft, analyze, build, or nothing
- **Context files to load** — from project defaults + keyword matching
- **Output Type label** — if the issue has no `ships`/`builds`/`learns` label, apply one based on content analysis. Never overwrite an existing label.

If nothing useful can be done → label as `human-only`, post brief comment explaining why.

## Step 5 — Process new issues

For issues where the agent can help:
1. Load the relevant context files (respect token budget — ~5K max context per issue)
2. Do the work: draft content, research, analyze, plan implementation
3. Post results as a comment on the issue
4. Label as `agent-pending` so the human reviews output
5. If output is substantial, write to `springs/[spring]/content/`

## Step 6 — Report

Write `logs/daily/YYYY-MM-DD.md`:

```markdown
# Daily Cycle — YYYY-MM-DD

## What happened
Scanned [N] issues across [N] projects. Worked on [N] issues,
left proposals on [N] for review, executed [N] approved issues.

## Needs your attention
- [N] **proposals waiting** — [Issue name], [Issue name].
- [N] **blockers** — [Issue name]: [reason].
- [N] **overdue** — [Issue name]: due [date].

(If nothing needs attention, say "Nothing urgent.")

## What I did
For each issue worked on:
- [What was done] → [Issue name]
- Labeled [N] issues as human-only ([brief reasons])

## Pattern alert
- **Ship queue:** [N] issues labeled `ships` in active states (empty = alarm)
- **Build:ship ratio:** [N] builds : [N] ships across all active issues
- **Stale issues:** [N] issues in same state for 2+ weeks
- **Oldest open:** [issue name] — created [date] ([N] days ago)

(If Output Type labels not set up yet, note it and skip pattern metrics.)
```

Delete any report files in `logs/daily/` older than 7 days.

Present the report to the user.
