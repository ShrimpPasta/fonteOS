# Getting Started

From zero to your first working session. No server, no build step, no account.

---

## Prerequisites

- **Claude Code** — the Anthropic CLI. Required. Install at [claude.ai/code](https://claude.ai/code).
- **Git** — for cloning and version control.
- **jq** — for hook scripts. Install with `brew install jq` (Mac) or `apt install jq` (Linux).
- **Obsidian** — optional but recommended. If you skip it, any markdown editor works — you just won't have the graph view.

---

## Step 1 — Clone

```bash
git clone https://github.com/luke-toledo/fonteOS.git my-vault
cd my-vault
```

Replace `my-vault` with whatever you want to call your vault directory.

---

## Step 2 — Open in Obsidian (optional)

In Obsidian, go to **Open folder as vault** and select your cloned directory. This gives you graph visualization of how your files connect — useful but not required to run the system.

---

## Step 3 — Start Claude Code

Open a terminal in your vault directory:

```bash
claude
```

Claude Code loads `CLAUDE.md` automatically. The behavioral rules are already active before you type anything.

---

## Step 4 — First /start

Type:

```
/start
```

Claude detects that `source/core.md` is empty and runs the first-run setup:

1. **Who are you and what are you building?** — Claude populates your identity and mission.
2. **Top 2-3 priorities** — what matters most right now, and on what timeline.
3. **Task manager** — connect Linear (recommended), Asana, or choose vault-only mode (you can add this later).
4. **First spring** — Claude creates your first project from priority #1: the spring index and stream directory.

The whole setup takes 5-10 minutes of back-and-forth. Answer directly — stream of consciousness is fine. Claude structures it.

---

## Step 5 — Your first work session

After setup, Claude establishes a **session deliverable** before work begins:

1. **Specific deliverable** — what exactly will this session produce?
2. **Type** — is this `ships` (market-facing), `builds` (internal), or `learns` (research)?
3. **Done definition** — what does "done" look like?
4. **First 15-minute action** — the smallest step to start moving.

Then you work. A few things to know:

- **Claude writes to streams freely.** Ask it to draft, research, analyze, outline — it goes directly into your stream files.
- **Changes to permanent files require your approval.** If Claude wants to update your spring index or intelligence files, it proposes the edit and waits.
- **Stray ideas go to inbox.** If something doesn't fit the current work, Claude drops it in `inbox/` rather than derailing the session.
- **Pattern monitoring is always on.** Claude watches for scope creep, prerequisite chains, and other common avoidance patterns. It flags them, doesn't block them.

---

## Step 6 — Your first /end

When you're done (or out of time), type:

```
/end
```

Claude runs the close protocol:

1. **Summarizes the session** — what was decided, what changed, what's next.
2. **Scope drift check** — compares what you declared vs. what actually happened. Data, not judgment.
3. **Verification** — checks that deliverables meet quality criteria (wikilinks, confidence markers, etc.).
4. **Task manager sync** — if you connected a task manager, proposes updates. You approve each one.
5. **Upstream or dispose** — codify outputs into permanent files, or just close.
6. **Writes session-state.md** — automatically. Next time you `/start`, Claude picks up cold.

---

## What the vault looks like after setup

```
my-vault/
├── CLAUDE.md                          ← Behavioral rules (protected by settings.json)
├── source/
│   ├── core.md                        ← Your mission, priorities, spring registry (populated)
│   ├── session-state.md               ← Last session summary (written at /end)
│   ├── pattern-reference.md           ← Pattern-breaking flags and health metrics
│   └── pm-reference.md                ← Task manager integration reference
├── springs/
│   └── your-first-project/
│       ├── your-first-project_index.md
│       └── stream/
│           └── (streams appear as you work)
├── intelligence/
├── agents/
├── inbox/
├── logs/
│   └── daily/                         ← Daily cycle reports (auto-cleaned after 7 days)
└── .claude/
    ├── settings.json                  ← Project-level settings (hooks + file protection)
    ├── hooks/
    │   ├── pre-session-snapshot.sh    ← Git safety net before each session
    │   └── validate-wikilinks.sh      ← Graph integrity check on every write
    └── commands/
        ├── start.md                   ← Session open + deliverable protocol
        ├── end.md                     ← Session close + drift check + verification
        ├── audit.md                   ← Monthly maintenance + pattern health
        ├── note.md                    ← Quick note creation
        ├── cycle.md                   ← Daily agent cycle (automated)
        ├── patterns.md                ← Quick pattern health check
        └── review.md                  ← Two-stage quality review
```

---

## Commands

| Command | What it does |
|---------|-------------|
| `/start` | Load context, suggest work, declare deliverable, scope to a project |
| `/end` | Summarize, drift check, verify, upstream or dispose, save state |
| `/audit` | Monthly maintenance — orphans, stale streams, pattern health, drift |
| `/note` | Create a new note with proper structure and wikilinks |
| `/cycle` | Daily agent cycle — scan issues, classify, execute what it can |
| `/patterns` | Quick pattern health check — ship queue, ratios, streaks |
| `/review` | Two-stage quality review — gap analysis then counter-review |

---

## From here

Every session follows the same loop: `/start` → work → `/end`. The system grows organically as you use it — streams accumulate, intelligence files graduate from recurring insights, springs multiply as your projects do.

Run `/audit` monthly to clean up orphans, check pattern health, and detect drift. Run `/patterns` anytime for a quick gut-check on whether you're shipping or just building.

That's it. The loop is the system.
