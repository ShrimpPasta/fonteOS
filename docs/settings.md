# Settings & Configuration

How Claude Code settings work with FonteOS — what ships with the vault, what you configure yourself, and how to upgrade.

---

## Two layers of settings

Claude Code settings work at two levels:

| Level | File | What it controls |
|-------|------|------------------|
| **User-level** | `~/.claude/settings.json` | Your global defaults — model, MCP servers, baseline permissions. Applies to all projects. |
| **Project-level** | `.claude/settings.json` | Vault-specific rules — hooks, file protection, project-specific permissions. Ships with FonteOS. |

Project-level settings **add to** user-level settings — they don't replace them. If your user-level config allows something and your project-level config denies it, the deny wins.

---

## What FonteOS ships (project-level)

FonteOS includes a `.claude/settings.json` with two things:

### File protection

```json
{
  "permissions": {
    "deny": [
      "Edit(/CLAUDE.md)",
      "Write(/CLAUDE.md)",
      "Edit(/.claude/settings.json)",
      "Write(/.claude/settings.json)"
    ]
  }
}
```

This prevents Claude from modifying the behavioral foundation (`CLAUDE.md`) or the settings themselves. These files are human-only — you edit them deliberately when you want to change how the system works.

### Hooks

Two hooks run automatically:

**Session snapshot** (`SessionStart`) — before every session, creates a git tag at the current commit. If Claude makes a mess, you can revert:

```bash
git tag -l "snapshot-*"              # list snapshots
git checkout snapshot-2026-04-07-1430  # revert to one
```

**Wikilink validation** (`PostToolUse` on Edit/Write) — after every markdown file edit, checks that the file contains at least one `[[wikilink]]`. Isolated files break the Obsidian graph. The hook warns but doesn't block — it's a nudge, not a gate.

---

## What you configure yourself (user-level)

Your user-level settings at `~/.claude/settings.json` are yours to manage. FonteOS doesn't touch them. Common things to configure:

### MCP servers

MCP integrations (Linear, Perplexity, Gemini, etc.) are configured at user-level or through Claude.ai platform integrations. See [mcp-integrations.md](mcp-integrations.md) for setup guides.

### Model and effort

```json
{
  "model": "opus",
  "effortLevel": "medium"
}
```

### Baseline permissions

If you want Claude to stop prompting you for common actions:

```json
{
  "permissions": {
    "allow": [
      "Read(/**)",
      "Edit",
      "Write",
      "Bash(git status)",
      "Bash(git log *)",
      "Bash(git diff *)",
      "Bash(git add *)",
      "Bash(git commit *)",
      "Agent",
      "WebSearch",
      "WebFetch"
    ],
    "deny": [
      "Bash(rm *)",
      "Bash(sudo *)",
      "Bash(git push --force *)",
      "Bash(git reset --hard *)"
    ]
  }
}
```

This is optional — Claude Code works fine with default permissions. You'll just get prompted more often.

---

## Upgrading to user-level

As you get comfortable with FonteOS, you may want to move some project-level settings to user-level so they apply across all your vaults:

**Hooks** — if you use FonteOS conventions in multiple vaults, move the hooks to user-level. Copy the hook scripts to `~/.claude/hooks/` and add the hook config to `~/.claude/settings.json`.

**File protection** — if you always want CLAUDE.md protected, add the deny rules to user-level. The project-level rules then become redundant (but harmless to keep).

**MCP permissions** — if you're tired of approving MCP tool calls, add specific tool allows to user-level:

```json
{
  "permissions": {
    "allow": [
      "mcp__claude_ai_Linear__list_issues",
      "mcp__claude_ai_Linear__get_issue",
      "mcp__perplexity__web_search",
      "mcp__gemini__extract_youtube"
    ]
  }
}
```

The project-local file (`.claude/settings.local.json`) also accumulates one-off approvals automatically — things you approve during sessions get saved there. This file is not committed to git.

---

## Protecting additional files

Once you've populated `source/core.md` with your real data, consider protecting it:

```json
{
  "permissions": {
    "deny": [
      "Edit(/source/core.md)",
      "Write(/source/core.md)"
    ]
  }
}
```

Add this to your project-level `.claude/settings.json`. Claude will still propose edits to core.md (as CLAUDE.md instructs), but the actual write will require you to temporarily lift the deny rule — an extra safety net for your most important file.

---

## Settings precedence

When settings conflict:

1. **Deny always wins** over allow, regardless of level
2. **Project-level** settings merge with user-level (they don't replace)
3. **Project-local** (`.claude/settings.local.json`) adds one-off approvals on top

In practice: set your baseline comfort level at user-level, add vault-specific protections at project-level, and let project-local accumulate your session-by-session approvals.

---

## Hook scripts

FonteOS ships two hook scripts in `.claude/hooks/`:

### `pre-session-snapshot.sh`

Creates a git tag before each session. Requires `jq` for JSON parsing (pre-installed on most systems). Uses `git rev-parse --show-toplevel` to find the repo root — works regardless of where Claude Code is launched from.

### `validate-wikilinks.sh`

Checks for `[[wikilinks]]` in edited markdown files. Skips files that legitimately don't need links: CLAUDE.md, README.md, session-state.md, log files, docs, specs, and landing page files. Warns on stdout — Claude sees the warning and can act on it.

Both scripts are designed to be non-blocking. They warn on issues but always exit 0 so they never prevent Claude from working.
