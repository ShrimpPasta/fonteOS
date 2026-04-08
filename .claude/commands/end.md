Execute the /end protocol defined in CLAUDE.md. Reference @source/pattern-reference.md for pattern-breaking context.

## 1. Summarize the session

Produce a concise summary with three sections:
- **Decided:** Key decisions made this session
- **Changed:** State deltas — files updated, issues completed, statuses shifted
- **Next:** Open issues, blockers, and suggested priority for next session

## 2. Scope drift check (pattern-breaking)

Compare the session deliverable declared at `/start` against what actually happened:
- **Declared deliverable:** [what was stated]
- **Actual output:** [what was produced]
- **Type:** ships / builds / learns
- **Drift?** Yes/No — if yes, note where it shifted and whether it was intentional

This is not a judgment — it's data. Track it so patterns become visible over time.

If no deliverable was declared at start (casual session, system work), skip this step.

## 3. Verification check

Before closing, check the session's work against verification criteria:
- **Content** → voice alignment, factual claims, no hedging language, wikilinks present
- **Vault writes** → frontmatter correct, wikilinks present, file in right location
- **Task manager ops** → fetch-back confirms mutation succeeded
- **Research** → conclusion stated, confidence marker assigned, sources cited
- **Code/config** → tested, no regressions

Ask: "Did we verify the deliverable? If not, should we before closing?"

If the operator says skip, skip. This is a check, not a gate.

## 4. Task manager sync

Review what was worked on this session. Propose updates:
- **Complete** issues that were finished during the session
- **Comment** on issues that were progressed but not finished (summarize what was done)
- **Label** issues if needed (agent-blocked, human-only, etc.)

Present each proposed action for approval before executing. Format:
- Issue: [name] → Action: [complete / comment / label] — [reason]

If no task manager issues were touched this session, skip this step.

## 5. Upstream or dispose

Ask: "Upstream or dispose?"

**If upstream:** Propose specific edits to relevant files. Present each change individually:
- Stream files → Claude drafts freely, user reviews
- Spring indexes, core.md, intelligence files → Claude proposes, human must approve before any write

For each proposed change, show: file path, what changes, and why.

**If dispose:** Close without ceremony. No guilt.

## 6. Update session state

After upstreaming (or disposing), draft the session summary for `source/session-state.md`. Include:
- Date, Spring scope, Streams worked, Decided, Changed, Open tasks, Blockers, Next session priority
- **Deliverable declared:** [what was stated at /start]
- **Deliverable actual:** [what was produced]
- **Type:** ships / builds / learns
- **Drift:** yes/no — and whether intentional

Present the draft to the user for approval before writing.

## 7. Session naming

Suggest: "Want to name this session? A descriptive name makes it easy to resume later."

Skip if the session was casual or short.
