# FonteOS

**A strategy and execution layer for solo founders and small teams using Claude Code.**

FonteOS gives Claude Code persistent memory, project awareness, and session continuity. It's a vault structure + behavioral rules — no server, no database, no build step. Clone it, open it, `/start`.

---

## What it solves

- You re-explain your context every Claude session
- You lose decisions, research, and progress between conversations
- You burn tokens re-loading context that should already be there
- Your projects bleed into each other with no isolation
- You have no structure connecting strategy (what to build) to execution (what to do next)

## How it works

**Two control files:**
- `CLAUDE.md` — behavioral rules Claude reads automatically. Session protocol, write permissions, standing rules.
- `source/core.md` — your operating context. Mission, priorities, project registry. Claude reads it, knows your world.

**Six-layer vault:**
- **Source** — mission, priorities, registries (updated weekly)
- **Springs** — projects/ventures, each with their own index
- **Streams** — active workstreams within a spring (where daily work happens)
- **Intelligence** — research-backed reference knowledge (graduated from streams)
- **Agents** — AI agent role definitions
- **Inbox** — loose ideas, triaged weekly

**Session lifecycle:**
```
/start → Claude loads your context, suggests work, scopes to a project
  ↓
work → Claude reads/writes within the scoped project, fetches external data via MCP
  ↓
/end → summarize, upstream insights to permanent files, save state for next session
```

**Token-efficient by design.** The vault structure means Claude loads ~5k tokens of context, not your entire life. MCP integrations fetch live data from your task manager, docs, and research tools on demand — external data stays external until needed.

---

## Quickstart

### 1. Clone

```bash
git clone https://github.com/ShrimpPasta/fonteos.git my-vault
cd my-vault
```

### 2. Open in Obsidian

Open the cloned folder as an Obsidian vault. (If you don't use Obsidian, any markdown editor works — you'll just miss the graph view.)

### 3. Start Claude Code

```bash
claude
```

### 4. First run

```
/start
```

On first run, Claude detects an empty `core.md` and walks you through setup:
- Who you are and what you're building
- Your top priorities
- Which task manager to connect (Asana, Linear, or none)
- Creates your first project from priority #1

After setup, every future `/start` loads your context instantly.

---

## Vault structure

```
my-vault/
├── CLAUDE.md                          ← Behavioral rules (auto-loaded)
├── source/
│   ├── core.md                        ← Mission, priorities, registries
│   └── session-state.md               ← Last session pickup
├── springs/
│   └── my-project/
│       ├── my-project_index.md        ← Project overview
│       └── stream/
│           └── .gitkeep
├── intelligence/
│   └── .gitkeep
├── agents/
│   └── .gitkeep
├── inbox/
│   └── .gitkeep
└── .claude/
    └── commands/
        ├── start.md
        ├── end.md
        ├── audit.md
        └── note.md
```

---

## Key concepts

| Concept | What it means |
|---------|---------------|
| **Source** | `core.md` — your mission, priorities, and project registry |
| **Spring** | A project or venture. Has an index and streams. |
| **Stream** | Active work within a spring. Claude writes here freely. |
| **Intelligence** | Research-backed reference. Slow-changing, confidence-rated. |
| **Upstream** | Codify session output into a permanent file. |
| **Dispose** | Close a session without extracting anything. |
| **Graduate** | Promote a recurring stream insight to Intelligence. |

---

## Write permissions

| Layer | Claude can write? | Notes |
|-------|-------------------|-------|
| Streams | Yes | Daily work, drafts |
| Inbox | Yes | Catching ideas |
| Session state | Yes | Auto-written at /end |
| Spring indexes | Propose only | Human approves |
| Intelligence | Propose only | Human approves |
| Source (core.md) | Propose only | Human approves |
| CLAUDE.md | Never | Human-only |

---

## Optional integrations (MCP)

FonteOS works standalone, but gets more powerful with MCP integrations:

| Integration | What it does |
|-------------|-------------|
| **Asana / Linear** | Pull tasks at /start, update at /end, daily cycle automation |
| **Perplexity** | Deep research without leaving the terminal |
| **Gemini** | YouTube video extraction, document analysis |
| **Google Drive** | Read spreadsheets and docs as intelligence sources |
| **Figma** | Read design files and extract design tokens |

See [docs/mcp-integrations.md](docs/mcp-integrations.md) for setup guides.

---

## Commands

| Command | What it does |
|---------|-------------|
| `/start` | Load context, suggest work, scope to a project |
| `/end` | Summarize session, upstream or dispose, save state |
| `/audit` | Monthly maintenance — find orphans, stale streams, drift |
| `/note` | Create a new note with proper structure and wikilinks |

---

## What it's NOT

- **Not a chatbot.** It's a working context for Claude Code.
- **Not a RAG pipeline.** No vectors, no embeddings. Just markdown files loaded strategically.
- **Not a SaaS.** No server, no account, no subscription.
- **Not an installer.** It's a file structure. Clone and go.

---

## Documentation

- [Getting Started](docs/getting-started.md)
- [Core Concepts](docs/concepts.md)
- [Session Lifecycle](docs/session-lifecycle.md)
- [Customization](docs/customization.md)
- [MCP Integrations](docs/mcp-integrations.md)
- [Voice Profiles](docs/voice-profiles.md)
- [Advanced: Multi-session Work](docs/advanced/multi-session.md)
- [Advanced: Daily Cycle Automation](docs/advanced/daily-cycle.md)

---

## License

MIT

---

## Credits

Built by [Luke](https://x.com/) in Lisbon. Born from running multiple ventures with Claude Code and needing a system that doesn't forget.

*"Fonte" is Portuguese for spring — the source where streams begin.*
