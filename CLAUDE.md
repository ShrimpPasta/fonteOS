## Session startup

On `/start`:
1. Read `source/core.md` → orient on mission, priorities, recent shifts.
2. Read `source/session-state.md` → if last session exists, surface it briefly.
3. **First-run detection** — if `core.md` has no identity section filled in, trigger the setup flow (see "First-run setup" below).
4. **Task manager sync** (if configured) — pull "Now" tasks for each project. Cross-reference with vault streams.
5. **Declare scope.** "This session is scoped to [spring]." Restrict writes to that spring's path unless cross-over is explicitly approved.
6. **Ask:** "What are we working on?" → Suggest top 2-3 options based on priority, recency, and blockers.
7. User picks. Read the relevant `[spring]_index.md` + stream file(s).
8. Work begins — only after required files are loaded.

### First-run setup

If `source/core.md` is empty or contains only the template placeholders:

1. Ask: "What's your name? What are you building?"
2. Ask: "What are your top 2-3 priorities right now?"
3. Ask: "Which task manager do you want to connect?" → Asana (default), Linear, or None (vault-only mode).
4. Populate `core.md` with their answers.
5. Create their first spring from priority #1 (index + stream directory).
6. If they chose a task manager: explain the MCP setup steps.
7. "You're set. From now on, type `/start` at the beginning of every session."

## General behavior

- Make autonomous decisions when direction is clear. Only pause for genuinely ambiguous choices.
- Operate as a **critical collaborator**, not a yes-machine. Push back, challenge assumptions, flag risks.
- Concise over comprehensive. Signal over validation. No hedging language.
- If something doesn't fit the current workstream, drop it in `/inbox/` for later triage.
- Restrict file operations to the vault directory. Never scan unrelated paths.
- When given a task, execute it now unless explicitly told "later" or "not yet."

## Standing rules

1. **Human-only writes** to Source, Spring indexes, Intelligence. Claude proposes; human approves. Streams are more flexible — Claude drafts freely.
2. **Spring isolation** — each session declares its spring and restricts writes to that path. Cross-spring edits require explicit approval. Cross-spring reads always permitted.
3. **Confidence markers** required on all Intelligence files (high / medium / low / speculative).
4. **Graduate protocol** — when a stream insight recurs 3+ times, promote it to an Intelligence file.
5. **Orphan audit** — monthly via `/audit`. Scan for disconnected files.
6. **Recent Shifts** — updated weekly in core.md. Rolling 2-week window.

## Vault navigation

| Layer | Path pattern |
|---|---|
| Source | `source/core.md` |
| Session state | `source/session-state.md` |
| Springs | `springs/[name]/[name]_index.md` |
| Streams | `springs/[name]/stream/[topic].md` |
| Intelligence | `intelligence/[topic].md` |
| Agents | `agents/[name].md` |
| Inbox | `inbox/` |

## Loading rules

**Hierarchy:** Source → Spring index → Stream → Intelligence (on demand).

**Token budget:** ~5,000 tokens of loaded context. 90%+ of the context window stays free for work. If a file doesn't fit, it's too long — trim it.

**What not to auto-load:** Agent files, springs/streams not relevant to current task.

## Session close (/end)

1. **Summarize:** what was decided, what changed, what's next.
2. **Task manager sync** (if configured) — propose updates: complete finished tasks, comment on progressed tasks.
3. **Upstream or dispose** — propose edits to relevant vault files (source, springs, intelligence require approval; streams Claude drafts freely), or just close.
4. **Write `source/session-state.md`** — update immediately. Session state is operational metadata, not knowledge.

## Write permissions

```
AUTONOMOUS (do it, log it)
├── Read any file in the vault
├── Write to streams, inbox, session-state
├── Read from task manager (if configured)
├── Post informational comments on tasks
├── Read from MCP integrations (research, docs, etc.)
└── Git add + commit + push

PROPOSE (present for approval)
├── Modify spring indexes, intelligence, core.md
├── Complete tasks in task manager
├── Change task status, dates, assignees
├── Create new tasks
├── Generate content for publication
└── Write to external systems

NEVER
├── Delete files or tasks
├── Modify CLAUDE.md
├── Access credentials or secrets
├── Send emails, post to social, publish
├── Modify git history (rebase, force push, amend)
└── Make financial transactions or API calls with cost
```

## Key terminology

| Term | Meaning |
|------|---------|
| **Source** | core.md — mission, priorities, registries |
| **Spring** | A project or venture. Has its own index and streams. |
| **Stream** | Active work within a spring. |
| **Intelligence** | Reference knowledge. Slow-changing, research-backed. |
| **Upstream** | Codify session output into a permanent file. |
| **Dispose** | Let a conversation close without extracting anything. |
| **Graduate** | Promote a recurring stream insight to Intelligence. |

## Monthly audit (/audit)

Scan for:
1. Intelligence files referenced by nothing
2. Streams inactive 30+ days
3. Agents with no intelligence references
4. Springs with no active streams
5. Inbox items older than 2 weeks
6. Vault↔task manager drift (if configured)

Output a table with recommended actions. Don't act until human confirms.

## Task manager integration (optional)

The vault is the strategy layer — direction, context, knowledge. Your task manager is the execution layer — tasks, priorities, status. They stay in sync through `/start`, `/end`, and `/audit`.

**Setup:** Configure your task manager's MCP server in Claude Code settings. See docs for Asana and Linear guides.

**"Now" is the shared execution surface.** Drag tasks into your "Now" section. The agent processes only "Now" tasks. Human sets priority, agent executes or proposes.
