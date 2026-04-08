Read these files:
- `source/core.md`
- `source/session-state.md`
- `source/pattern-reference.md`

Then execute the /start protocol defined in CLAUDE.md.

## First-run detection

Check if `source/core.md` has empty identity fields (Operator, North star are blank). If so, trigger the first-run setup flow defined in CLAUDE.md — walk the user through identity, priorities, and task manager selection before proceeding.

## Returning session

If session-state.md has a real last session (not "—"), surface it briefly:
"Last session was [date], scoped to [spring]. You were working on [streams]. Next priority was: [sentence]."

## Task manager briefing (optional)

After reading vault state, ask: **"Pull task manager issues for the briefing?"**

If yes: Read `source/stream-mapping.yaml` for project mappings and state config. For each mapped project, fetch open issues in "Todo"/"Now" state.

If no: Skip the pull entirely. Go straight to "What are we working on?" using vault context only (session-state.md priorities, stream status, core.md recent shifts).

Present a combined briefing:

```
[Spring Name] — [X issues in Todo]
  Streams: [active streams from vault index]
  Todo issues:
  - [issue name]
  - [issue name]
```

Only show springs that have issues in "Todo" or active streams. Keep it compact.

Then continue: suggest top 2-3 options combining stream priorities and task manager issues, declare scope, load relevant files.

## Session deliverable (pattern-breaking protocol)

After the user picks what to work on, establish these four things before work begins:

1. **Specific deliverable** — not "work on [project]" but "draft the landing page hero section." If vague, push for specificity.
2. **Type** — is this `ships` (market-facing, goes in front of a real human), `builds` (internal infrastructure), or `learns` (research)?
3. **Done definition** — what does "done" look like for this session?
4. **First 15-minute action** — the smallest on-ramp to start. Bypasses the executive function wall.

Record these in your working context. They'll be compared against actual output at `/end`.

If the session is casual conversation, brainstorming, or system maintenance — skip the deliverable protocol. It's for work sessions.
