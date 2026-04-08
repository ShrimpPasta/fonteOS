# Daily Cycle Automation

Setting up an automated daily agent that scans your task manager, classifies work, executes what it can, and reports what needs you.

---

## What the daily cycle does

The cycle is a non-interactive Claude session that runs on a schedule. It:

1. Scans all task manager projects for issues in "Todo"/"Now" state
2. Executes any previously approved proposals (`agent-approved` label)
3. Classifies each remaining issue — what type of work, can an agent help, what context is needed
4. Executes what it can — research, drafts, analysis — and writes results to the vault
5. Posts summaries as comments on the relevant issues
6. Tags issues that need human input and leaves clear notes on why
7. Applies `ships`/`builds`/`learns` labels for pattern tracking
8. Writes a daily log at `logs/daily/YYYY-MM-DD.md`

The output is: work done autonomously, and a clear handoff of what still needs you.

---

## Prerequisites

- A task manager MCP configured (Linear recommended, Asana also supported) — see [mcp-integrations.md](../mcp-integrations.md)
- `source/stream-mapping.yaml` with your project/spring mappings
- The `/cycle` command file in `.claude/commands/cycle.md` (ships with FonteOS)

---

## The execution surface

The cycle only processes issues in "Todo"/"Now" state. This is intentional — you control what the agent touches by what you move there.

The handshake:
- **You** move issues to "Todo" when they're ready for agent processing
- **The cycle** processes them and posts results
- **You** review what the agent did, approve or redirect

Don't put issues in "Todo" that you don't want the agent touching. Use "Backlog" for issues that are prioritized but not yet agent-ready.

---

## Labels and their meaning

The cycle uses labels to communicate state:

| Label | Set by | Meaning |
|-------|--------|---------|
| `agent-pending` | Agent | Proposal awaiting your review |
| `agent-approved` | You | You approved, agent should execute next cycle |
| `agent-blocked` | Agent | Agent can't proceed, needs your input |
| `human-only` | Agent | Agent assessed: nothing useful it can do here |
| `ships` | Agent/You | Market-facing output (pattern tracking) |
| `builds` | Agent/You | Internal infrastructure (pattern tracking) |
| `learns` | Agent/You | Research/exploration (pattern tracking) |

The cycle doesn't touch issues labeled `human-only`. If you want a `human-only` issue reconsidered, remove the label and move it back to "Todo."

---

## Stream-mapping.yaml reference

The cycle reads this file to know which projects to scan and what context to load:

**For Linear:**
```yaml
# source/stream-mapping.yaml

projects:
  product:
    id: "project-uuid"
    name: "Product"
    spring_index: "springs/product/product_index.md"
    content_dir: "springs/product/content/"
    context_files:
      - springs/product/product_index.md
      - springs/product/stream/roadmap.md
      - intelligence/market-landscape.md
    extra_context_by_keyword:
      content:
        - intelligence/voice.md
        - intelligence/audience.md

  marketing:
    id: "project-uuid-2"
    name: "Marketing"
    spring_index: "springs/marketing/marketing_index.md"
    content_dir: "springs/marketing/content/"
    context_files:
      - springs/marketing/marketing_index.md
      - intelligence/voice.md
```

**For Asana:**
```yaml
projects:
  product:
    project_gid: "1234567890"
    now_section_gid: "0987654321"
    spring_index: "springs/product/product_index.md"
    context_files:
      - springs/product/product_index.md
```

The `context_files` list tells the cycle what to load before working on issues from that project. The `extra_context_by_keyword` section loads additional files when issue content matches specific keywords. Keep both lean.

---

## Scheduled triggers

The cycle runs manually via `/cycle` or automatically on a schedule:

**Using cron + Claude Code CLI:**

```bash
# Add to crontab: crontab -e
0 6 * * * cd /path/to/your-vault && claude --no-interactive --command "/cycle" >> logs/cycle-cron.log 2>&1
```

**Timing considerations:**
- Run it before your workday starts — so the report is ready when you sit down
- The command includes an idempotency gate (checks for existing daily log) on automated runs
- Manual `/cycle` runs skip the gate

---

## Daily log format

```markdown
# Daily Cycle — YYYY-MM-DD

## What happened
Scanned [N] issues across [N] projects. Worked on [N] issues,
left proposals on [N] for review, executed [N] approved issues.

## Needs your attention
- [N] **proposals waiting** — [Issue name], [Issue name].
- [N] **blockers** — [Issue name]: [reason].
- [N] **overdue** — [Issue name]: due [date].

## What I did
- [What was done] → [Issue name]
- Labeled [N] issues as human-only

## Pattern alert
- **Ship queue:** [N] active `ships` issues
- **Build:ship ratio:** [N:N]
- **Stale issues:** [N] in same state 2+ weeks
```

Logs are stored at `logs/daily/YYYY-MM-DD.md` and deleted automatically after 7 days.

---

## What the agent can and can't do

**Can do autonomously:**
- Research tasks (search, synthesis, structured output)
- Draft content (using voice profile and context files)
- Competitive analysis, market research
- Summarizing source material
- Organizing and structuring information
- Applying `ships`/`builds`/`learns` labels

**Requires human involvement:**
- Decisions (the agent surfaces options, you choose)
- Relationship tasks (calls, meetings, follow-ups)
- Financial actions
- Publishing or sending anything externally
- Anything requiring judgment beyond the available context

The cycle eliminates research/drafting/synthesis work that doesn't require your specific judgment — so when you sit down, you're reviewing and deciding, not starting from scratch.
