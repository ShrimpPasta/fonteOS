Run a pattern-breaking self-audit. Read @source/pattern-reference.md for definitions and thresholds.

This is a focused check — lighter than `/audit`, takes 30 seconds. Run anytime you want a gut-check on execution patterns.

## Step 1 — Pull task manager state

Read `source/stream-mapping.yaml` for project mappings. Fetch all open issues across all mapped projects (all states, not just "Todo").

If no task manager is configured, skip to Step 2 and use session-state.md data only.

## Step 2 — Check pattern health metrics

### Ship queue
Count issues labeled `ships` that are not Done/Cancelled.
- **Alarm:** Ship queue is empty → "Your ship queue is empty. Nothing is currently moving toward market contact."
- **Healthy:** List active `ships` issues.

### Build:ship ratio
Count issues labeled `builds` vs `ships` across all active (non-Done) issues.
- **Flag:** Ratio >4:1 → "You have [N] build tasks for every [N] ship task. The infrastructure pattern may be active."
- **Healthy:** Show ratio.

### Stale issues
Find issues that have been in the same state for 2+ weeks.
- **Flag:** List each stale issue with age and current state.
- **Healthy:** "No stale issues."

### Oldest open issue
Find the oldest non-Done issue by created date.
- **Flag:** >4 weeks old → "Your oldest open issue is [N] days old: [name]. Still relevant?"

### Weekly ship rate
Count `ships` issues completed in the last 4 weeks (one count per week).
- **Flag:** Any week with 0 completions → "Week of [date]: nothing shipped."
- **Streak:** Count consecutive weeks with 1+ `ships` completed. "Ship streak: [N] weeks."

### Session drift (if session-state.md has deliverable tracking)
Read `source/session-state.md`. For recent sessions with deliverable tracking (declared vs actual), check drift rate.
- **Flag:** >50% of tracked sessions drifted → "You're drifting in [N]% of sessions."
- **Healthy:** Show drift rate.

If no deliverable tracking data yet, note: "No session drift data yet — will build as /start and /end track deliverables."

## Step 3 — Output report

```markdown
# Pattern Check — YYYY-MM-DD

## Ship queue: [status]
[N] active `ships` issues: [list]
(or: EMPTY — nothing moving toward market contact)

## Build:ship ratio: [N:N]
[assessment]

## Stale issues: [N found]
[list with age, or "None"]

## Oldest open: [name] — [N] days
[flag if >4 weeks]

## Weekly ship rate (last 4 weeks)
- Week of [date]: [N] shipped
- Week of [date]: [N] shipped
- Week of [date]: [N] shipped
- Week of [date]: [N] shipped
Ship streak: [N] consecutive weeks

## Session drift: [N]%
[assessment, or "No data yet"]

## Overall
[1-2 sentence honest assessment. Is an avoidance pattern active? Is market contact happening? What's the single most important thing to address?]
```

If Output Type labels (`ships`/`builds`/`learns`) don't exist yet in your task manager, flag it clearly.

Present the report. No changes to make — this is read-only.
