Read these files:
- `source/core.md`
- `source/session-state.md`

Then execute the /start protocol defined in CLAUDE.md.

## First-run detection

Check if `source/core.md` has empty identity fields (Operator, North star are blank). If so, trigger the first-run setup flow defined in CLAUDE.md — walk the user through identity, priorities, and task manager selection before proceeding.

## Returning session

If session-state.md has a real last session (not "—"), surface it briefly:
"Last session was [date], scoped to [spring]. You were working on [streams]. Next priority was: [sentence]."

## Task manager briefing (if configured)

If a task manager MCP is available, pull "Now" tasks for each project. Present a combined briefing:

```
[Spring Name] — [X tasks in Now]
  Streams: [active streams from vault index]
  Now tasks:
  - [task name]
  - [task name]
```

Only show springs that have tasks in "Now" or active streams. Keep it compact.

Then continue: suggest top 2-3 options, declare scope, load relevant files.
