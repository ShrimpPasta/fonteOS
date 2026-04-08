# Session Lifecycle

How a session starts, runs, and closes. What Claude reads, when, and why.

---

## /start

When you type `/start`, Claude executes a fixed sequence:

**1. Read `source/core.md`**
Claude orients on your mission, current priorities, recent shifts, and spring registry. This is the session foundation.

**2. Read `source/session-state.md`**
If a previous session exists, Claude surfaces it briefly:
> "Last session: [date], scoped to [spring]. You were working on [streams]. Next priority was: [sentence]."

**3. Read `source/pattern-reference.md`**
Loads pattern monitoring context. Claude watches for avoidance patterns throughout the session.

**4. Task manager sync (optional)**
Claude asks: "Pull task manager issues for the briefing?" If yes, it fetches "Todo"/"Now" issues and presents them alongside vault stream status. If no, it uses vault context only.

**5. Declare scope**
Claude announces which spring this session is working in and restricts writes to that path. It suggests 2-3 options based on priority and recency.

**6. You pick**
Claude loads the relevant spring index (`[spring]_index.md`) plus the stream files you're working in.

**7. Session deliverable**
Before work begins, Claude establishes four things:
- **Specific deliverable** — concrete, not vague
- **Type** — ships (market-facing), builds (internal), or learns (research)
- **Done definition** — what does "done" look like?
- **First 15-minute action** — the smallest step to get moving

These get tracked and compared against actual output at `/end`.

**8. Work begins**
Only after all required files are loaded and the deliverable is clear.

---

## During a session

Once started, Claude operates with spring isolation. A few things that matter:

**Writes stay in scope.** Claude writes freely to stream files within the declared spring. Everything else requires approval.

**Stray ideas go to inbox.** If something comes up that doesn't belong to the current stream or spring, Claude drops it in `inbox/` with a note.

**Cross-spring reads are always permitted.** Cross-spring writes require explicit approval.

**Pattern monitoring is always on.** Claude watches for scope creep, dependency chains, abstraction escalation, and quality threshold creep. It flags patterns — it doesn't block them. You decide whether the expansion is intentional or avoidance.

**Claude makes decisions when direction is clear.** It only pauses for genuinely ambiguous choices.

**MCP calls are on demand.** Research, tasks, design files, documents — fetched when needed, not at startup.

---

## What "upstream" means

At the end of a session, you have two choices for each piece of work:

**Upstream** — codify the output into a permanent file. Stream files Claude writes directly. Spring indexes, intelligence files, or core.md require approval. The insight becomes a durable artifact in the vault.

**Dispose** — close without extracting anything. Sometimes a session is just working through something and the conversation itself is the output. Dispose is not failure — it's a legitimate choice.

Be selective — only promote things that will matter later.

---

## /end

When you type `/end`, Claude runs the close protocol in seven steps:

**1. Session summary**
- **Decided:** Key decisions made
- **Changed:** Files updated, tasks completed
- **Next:** Open tasks, blockers, suggested priority

**2. Scope drift check**
Compares the declared deliverable against actual output:
- What was declared vs. what was produced
- Type: ships / builds / learns
- Drift: yes/no, and whether intentional

This is data, not judgment. Tracked over time so patterns become visible.

**3. Verification check**
Claude checks the session's work:
- Content → voice alignment, wikilinks present
- Vault writes → frontmatter correct, right location
- Task manager → mutations confirmed
- Research → confidence markers assigned

Asks: "Did we verify? If not, should we before closing?" You can skip.

**4. Task manager sync**
Proposes updates: complete finished issues, comment on progressed ones. Each action presented for approval.

**5. Upstream or dispose**
For each piece of work, choose to codify or close.

**6. Write session-state.md**
Structured summary with deliverable tracking fields. Presented for approval, then written.

**7. Session naming**
Suggestion to name the session for easy resume later.

---

## Session state as the bridge

`session-state.md` contains structured session data including deliverable tracking:

```markdown
## Last session

- **Date:** YYYY-MM-DD
- **Spring scope:** [spring]
- **Streams:** [what was worked on]
- **Decided:** [key decisions]
- **Changed:** [files updated, tasks completed]
- **Open tasks:** [what's left]
- **Blockers:** [what's stuck]
- **Deliverable declared:** [what was stated at /start]
- **Deliverable actual:** [what was produced]
- **Type:** ships / builds / learns
- **Drift:** yes / no

## Next session priority

[One-sentence description of where to pick up]
```

When you start your next session, Claude reads this and picks up cold. The loop is: `/start`, Claude briefs you, you confirm or redirect, work resumes.

---

## Spring isolation

Each session is scoped to exactly one spring. This is a hard constraint, not a guideline.

**Why it matters:** Parallel sessions on different springs can't collide. Session A writes to `springs/product/stream/`, Session B writes to `springs/freelance/stream/`. No conflicts.

**What isolation means in practice:**
- Writes restricted to the declared spring's path
- Cross-spring edits require explicit approval
- `core.md`, `intelligence/`, and spring indexes are single-writer per work block
- Cross-spring reads always permitted

For detail on parallel sessions, see [advanced/multi-session.md](advanced/multi-session.md).

---

## The full loop

```
/start
  → reads core.md + session-state.md + pattern-reference.md
  → (optional) pulls task manager issues
  → declares scope, suggests work
  → establishes session deliverable (ships/builds/learns)
  → you pick, loads spring index + streams
  → work begins

[work]
  → Claude writes streams freely
  → proposes changes to permanent files
  → pattern monitoring flags in real time
  → MCP calls as needed
  → inbox for strays

/end
  → summarizes: decided, changed, next
  → scope drift check (declared vs actual)
  → verification check
  → (optional) proposes task manager updates
  → upstream or dispose
  → writes session-state.md with deliverable tracking
  → suggests session name
```

The loop is fast when you run it consistently. Skipping `/end` breaks session continuity. Skipping `/start` means Claude doesn't know your context. Run both.
