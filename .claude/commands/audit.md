Read `source/core.md` now if not already loaded.

Then execute the /audit protocol — a maintenance scan to find orphans, stale items, vault-task manager drift, and pattern health.

## Step 1 — Load all spring indexes

Read every spring index listed in core.md's spring registry.
Also check `inbox/` for loose files.

## Step 2 — Pull task manager state (if configured)

If a task manager MCP is available, read `source/stream-mapping.yaml` for project mappings.
Fetch all open issues across all projects (not just "Todo" — all states, to detect drift).

If no task manager is configured, skip this step.

## Step 3 — Scan for these conditions

1. **Orphaned intelligence** — files in `intelligence/` referenced by no stream or spring index
2. **Inactive streams** — streams with no activity in 30+ days (check `updated:` frontmatter)
3. **Blind agents** — agent files with no referenced intelligence files
4. **Empty springs** — springs with no active streams
5. **Stale inbox** — items in `inbox/` older than 2 weeks
6. **Vault-task manager drift** (if configured):
   - Streams listed as "Active" but no corresponding issues (work without tracking)
   - "Todo" issues that don't map to any vault stream (execution without context)

## Step 4 — Pattern health check

Read `source/pattern-reference.md` for metrics definitions. Then check:

| Metric | How to check | Alarm |
|--------|-------------|-------|
| **Ship queue** | Count issues labeled `ships`, status != Done | Empty = alarm |
| **Build:ship ratio** | Count `builds` vs `ships` across all active issues | >4:1 = flag |
| **Oldest open issue** | Sort all issues by created date ascending | >4 weeks = flag |
| **Stale issues** | Issues in same state for 2+ weeks | Any = flag |
| **Weekly hit rate** | `ships` issues completed in last 4 weeks (per week) | 0 in any week = flag |

Present as a "Pattern Health" section in the report. Be direct — data, not judgment.

If Output Type labels (`ships`/`builds`/`learns`) don't exist yet, note as a setup gap and skip label-dependent metrics.

## Step 5 — Output the audit report

Format as a clean table for each category:

| Item | Type | Issue | Recommended action |
|------|------|-------|--------------------|
| [file or issue] | [type] | [what's wrong] | Archive / Connect / Graduate / Delete / Create stream / Create issue |

If nothing found in a category, say "None" — don't skip the category.

Then output the Pattern Health section separately.

## Step 6 — System maintenance checks

**CLAUDE.md health:** Is every line still load-bearing? Would removing it cause mistakes? Flag if above ~150 lines.

**Integration check:** Any new Claude Code features or MCP servers relevant to this vault?

## Step 7 — Wait for confirmation

Do not make any changes until the user confirms which actions to take.
Present the full report first, then ask: "Which actions should I take? Reply with item names or 'all'."
