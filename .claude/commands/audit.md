Read `source/core.md` now if not already loaded.

Execute the /audit protocol — a maintenance scan to find orphans, stale items, and drift.

## Step 1 — Load all spring indexes

Read every spring index listed in core.md's spring registry.
Also check `inbox/` for loose files.

## Step 2 — Task manager state (if configured)

If a task manager MCP is available, fetch all incomplete tasks across all projects (not just "Now" — all sections, to detect drift).

## Step 3 — Scan for these conditions

1. **Orphaned intelligence** — files in `intelligence/` referenced by no stream or spring index
2. **Inactive streams** — streams with no activity in 30+ days (check `updated:` frontmatter)
3. **Blind agents** — agent files with no referenced intelligence files
4. **Empty springs** — springs with no active streams
5. **Stale inbox** — items in `inbox/` older than 2 weeks
6. **Vault↔task manager drift** (if task manager configured):
   - Streams listed as "Active" but no corresponding tasks
   - "Now" tasks that don't map to any vault stream

## Step 4 — Output the report

| Item | Type | Issue | Recommended action |
|------|------|-------|--------------------|
| [file or task] | [type] | [what's wrong] | Archive / Connect / Graduate / Delete / Create stream / Create task |

If nothing found in a category, say "None."

## Step 5 — Wait for confirmation

Do not make changes until the user confirms. Present the full report, then ask: "Which actions should I take?"
