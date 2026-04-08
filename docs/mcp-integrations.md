# MCP Integrations

FonteOS works without any of these. MCP integrations add capability — task management, research, design access, document reading — but the base system runs entirely on markdown files and Claude Code.

Add integrations as you need them, not all at once.

---

## How MCP works

MCP (Model Context Protocol) lets Claude call external tools during a session. You configure servers in your Claude Code settings. Once configured, Claude can call them naturally — no special syntax required, just "look up this task" or "search Perplexity for X."

Data fetched via MCP stays external until needed. Claude doesn't pre-load it — it calls the tool when you or the session protocol asks for it. This keeps the token budget clean.

---

## Linear (recommended task manager)

**What it does:** Pull issues, create issues, update status, post comments — all from the terminal. At `/start`, Claude fetches your "Todo" issues per project and presents them alongside vault stream status. At `/end`, Claude proposes issue updates for your approval.

**When to use it:** If you use Linear for task management, this is the primary integration. Issues in "Todo" state become the shared execution surface — you move them there, Claude processes them.

**Setup:**

Linear's MCP is available through Claude's platform integrations. Enable it in Claude Code settings and authenticate.

Once connected, map your Linear projects to FonteOS springs in `source/stream-mapping.yaml`:

```yaml
# source/stream-mapping.yaml
projects:
  my-project:
    id: "project-uuid"
    name: "My Project"
    spring_index: "springs/my-project/my-project_index.md"
    content_dir: "springs/my-project/content/"
    context_files:
      - springs/my-project/my-project_index.md
      - intelligence/voice.md
```

Find project IDs via Linear API or by asking Claude to list your projects via the MCP.

**Labels:** Set up these labels in Linear for agent workflow:
- `agent-pending` — agent output needs your review
- `agent-approved` — you approved, agent executes next cycle
- `agent-blocked` — agent can't proceed, needs your input
- `human-only` — agent should not touch this issue

And these for pattern tracking:
- `ships` — market-facing output
- `builds` — internal infrastructure
- `learns` — research and exploration

---

## Asana (alternative task manager)

**What it does:** Same integration pattern as Linear — pull tasks, update status, comment — for teams using Asana.

**Setup:**

Asana's MCP is available through Claude's platform integrations. Enable it in Claude Code settings, then authenticate with your Asana account.

Map your Asana projects to springs:

```yaml
# source/stream-mapping.yaml
projects:
  my-project:
    project_gid: "1234567890"
    now_section_gid: "0987654321"
    spring_index: "springs/my-project/my-project_index.md"
    context_files:
      - springs/my-project/my-project_index.md
```

Find project and section GIDs from the Asana URL or by asking Claude to list your projects.

---

## Perplexity (research)

**What it does:** Deep research with sourced, multi-page answers. Good for competitor analysis, market research, community/Reddit mining, technical deep-dives.

**When to use it:** When you need sourced answers — not casual lookups. Use Perplexity when you need current information, specific sources, or community sentiment.

**Cost note:** `deep_research` is a paid API call. FonteOS's CLAUDE.md includes a cost gate — Claude will ask before calling it. Regular `web_search` is lightweight and ungated.

**Setup:**

```json
{
  "mcpServers": {
    "perplexity": {
      "command": "npx",
      "args": ["-y", "@anthropic/perplexity-mcp-server"],
      "env": {
        "PERPLEXITY_API_KEY": "pplx-..."
      }
    }
  }
}
```

---

## Gemini (video and documents)

**What it does:** YouTube video extraction (timestamped summaries, key points, quotes), document analysis (PDFs, images), and general vision tasks.

**When to use it:** Processing YouTube videos for research, extracting structured data from PDFs, analyzing screenshots.

**Cost note:** `analyze_document` is a paid API call (cost-gated in CLAUDE.md). `extract_youtube` and `vision_analyze` are lightweight — no gate.

**Setup:**

```json
{
  "mcpServers": {
    "gemini": {
      "command": "npx",
      "args": ["-y", "@anthropic/gemini-mcp-server"],
      "env": {
        "GOOGLE_API_KEY": "AIza..."
      }
    }
  }
}
```

---

## Google Drive (file access)

**What it does:** Read-only access to Google Sheets and Docs. Pull spreadsheet data, document content, or shared files directly into Claude's context.

**When to use it:** When your source of truth lives in Google Drive and you need Claude to reference it.

**Setup:**

```json
{
  "mcpServers": {
    "google-drive": {
      "command": "npx",
      "args": ["-y", "@anthropic/gdrive-mcp-server"],
      "env": {
        "GOOGLE_CLIENT_ID": "...",
        "GOOGLE_CLIENT_SECRET": "..."
      }
    }
  }
}
```

---

## Google Calendar (scheduling)

**What it does:** Read calendar events, find free time, create events. Useful for schedule-aware planning and time blocking.

**When to use it:** When Claude needs to know your availability or help schedule work blocks.

**Setup:** Available through Claude's platform integrations. Enable and authenticate.

---

## Figma (design)

**What it does:** Read design files, get component screenshots, extract design tokens, access FigJam boards.

**When to use it:** When you work with designs and need Claude to understand what's been designed — for code generation, design review, or extracting specs.

**Setup:** Available through Claude's platform integrations. Enable and authenticate.

---

## Adding multiple integrations

Run multiple MCP servers simultaneously. Add each to your settings:

```json
{
  "mcpServers": {
    "perplexity": { ... },
    "google-drive": { ... },
    "gemini": { ... }
  }
}
```

At `/start`, Claude uses available MCPs as needed. Unavailable integrations don't block the session.
