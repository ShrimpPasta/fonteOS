Execute the /end protocol defined in CLAUDE.md.

## 1. Summarize the session

Produce a concise summary:
- **Decided:** Key decisions made this session
- **Changed:** Files updated, tasks completed, statuses shifted
- **Next:** Open tasks, blockers, suggested priority for next session

## 2. Task manager sync (if configured)

If a task manager MCP is available, propose updates:
- **Complete** tasks that were finished
- **Comment** on tasks that were progressed but not finished
- Present each proposed action for approval before executing.

If no task manager is configured, skip this step.

## 3. Upstream or dispose

Ask: "Upstream or dispose?"

**If upstream:** Propose specific edits to relevant files:
- Stream files → Claude drafts freely, user reviews
- Spring indexes, core.md, intelligence → Claude proposes, human approves

**If dispose:** Close without ceremony.

## 4. Update session state

Write `source/session-state.md` with the session summary. Overwrite completely — only the most recent session matters.
