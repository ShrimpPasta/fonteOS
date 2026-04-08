# Customization

How to adapt FonteOS to your actual work. Adding springs, creating streams, building intelligence, writing slash commands, defining agents, and extending with skills.

---

## Adding a spring

A spring is a folder in `springs/` with an index file. Create one when you're starting a new project or venture that deserves its own isolated context.

**Folder structure:**
```
springs/
└── my-new-project/
    ├── my-new-project_index.md
    └── stream/
        └── .gitkeep
```

**Index file template:**
```markdown
---
type: spring-index
spring: my-new-project
status: active
tags: [spring-index]
updated: YYYY-MM-DD
---

# My New Project

> Connected to: [[core]]
> **Status:** Active

## Scope

What this project covers. One or two sentences.

## Active streams

| Stream | Scope | Status | Last touched |
|--------|-------|--------|--------------|
| | | | |

## Referenced intelligence

<!-- Links to intelligence files relevant to this project -->

## Key people

<!-- Collaborators, stakeholders, advisors -->

## Recent decisions

<!-- Date: decision made -->

## Open questions

<!-- What's unresolved -->
```

Then add the spring to the registry in `source/core.md`. Claude can propose this edit at `/end`, or you can do it manually.

---

## Creating streams

Streams are markdown files in `springs/[spring]/stream/`. Create one per topic area — a product decision, a research thread, a client relationship, a content strategy.

**Stream file template:**
```markdown
---
type: stream
spring: my-project
status: active
tags: [my-project, topic-name]
updated: YYYY-MM-DD
---

# Topic Name

> Connected to: [[my-project_index]], [[relevant-intelligence-file]]

## Context

Why this workstream exists. What problem it's solving.

## Current state

What's happening now.

## Working notes

[Daily work goes here — Claude writes freely]

## Open questions

- Question 1
- Question 2

## Decisions log

- YYYY-MM-DD: Decision made and why
```

You can also create streams via `/note` — Claude will prompt you for the details and handle the file creation with proper wikilinks.

---

## Building intelligence files

Intelligence files live in `intelligence/` (global) by default. They're reference knowledge — slower-changing than streams, higher confidence, loaded on demand.

**Per-spring intelligence (advanced):** For larger vaults, you can organize intelligence per-spring at `springs/[name]/intel/`. This keeps project-specific research close to the project. Update CLAUDE.md's vault navigation table if you use this pattern.

Create an intelligence file when:
- A stream insight has recurred 3+ times (graduate protocol)
- You've done deep research that should be reusable across sessions
- There's stable reference material Claude should be able to load when relevant

**Intelligence file template:**
```markdown
---
type: intelligence
confidence: high        # high / medium / low / speculative
tags: [topic, scope]
updated: YYYY-MM-DD
---

# Topic Name

> **Confidence:** High — [brief note on source quality]
> Connected to: [[relevant-stream]], [[core]]

## Summary

2-3 sentence overview. What this file is for.

## Key findings

- Finding 1
- Finding 2
- Finding 3

## Detail

Deeper content organized by subtopic.

## Sources

- Source 1 — [URL or reference]
- Source 2

## What this changes

How this intelligence affects decisions or priorities.

## What's still unknown

Gaps, caveats, things to research further.
```

Add every new intelligence file to the intelligence registry in `core.md`. Also link it from any spring index or stream that references it.

---

## Writing custom slash commands

Slash commands live in `.claude/commands/` as markdown files. Each filename becomes a `/command` you can trigger in any session. The file content is the prompt Claude follows when you trigger it.

FonteOS ships with 7 commands (`start`, `end`, `audit`, `note`, `cycle`, `patterns`, `review`). Add your own for repetitive workflows.

**Basic command structure:**
```markdown
Brief description of what this command does.

## Steps

1. Step one
2. Step two
3. Step three

Use $ARGUMENTS for user input passed after the command name.
```

**Research command example:**
```markdown
Deep research on the topic provided by the user.

The user's topic is: $ARGUMENTS

Steps:
1. Use the Perplexity MCP to research the topic. Prioritize primary sources.
2. Present findings:
   - Summary — 2-3 sentence overview
   - Key findings — 5-10 bullet points
   - Sources — URLs with brief descriptions
   - Confidence — assess source quality (high/medium/low/speculative)
3. Ask: "Save as intelligence file, drop in inbox, or just use it here?"
```

**Video extraction command example:**
```markdown
Analyze a YouTube video using Gemini.

URL: $ARGUMENTS

Steps:
1. Extract video content using the Gemini MCP.
2. Present: title, summary, key points with timestamps, notable quotes.
3. Ask: "Save as intelligence file, drop in inbox, or just use it here?"
```

Place command files in `.claude/commands/`. They're available immediately — no restart needed.

---

## Skills (global extensions)

Skills are reusable prompt files that live in `~/.claude/skills/` (global, available across all vaults). They differ from slash commands: commands are vault-specific workflows, skills are portable capabilities.

**Useful skill categories:**

| Category | Examples |
|----------|----------|
| **Design** | `d-polish` (final quality pass), `d-critique` (UX evaluation), `d-animate` (motion design), `d-audit` (a11y + perf check) |
| **Content** | `humanize` (remove AI patterns), `story-edit` (narrative crafting) |
| **System** | `review` (two-stage quality check), `patterns` (health audit) |

Skills are invoked with `/skill-name` just like commands. To add a skill, create a `.md` file in `~/.claude/skills/` with the prompt.

---

## Defining agents

Agent files live in `agents/`. An agent is a defined AI role with specific instructions, intelligence references, and constraints.

**Agent file template:**
```markdown
---
type: agent
role: [role name]
model: [sonnet / opus]
tags: [agent, role-name]
updated: YYYY-MM-DD
---

# Agent Name

> Connected to: [[core]], [[relevant-intelligence]]

## Role

What this agent does. One sentence.

## When to load this agent

Specific triggers — what type of request should use this agent.

## Intelligence to load

- [[intelligence/file-one]] — why it's relevant
- [[intelligence/file-two]] — why it's relevant

## Instructions

Detailed behavioral rules for this agent role.

## Output format

What this agent should produce. Structure, length, format.

## Constraints

- What this agent should never do
- Boundaries
```

**Dual-brain model (recommended for complex vaults):**
- **Orchestrator agent** (Opus) — strategy, deep analysis, cross-spring thinking
- **Operations agent** (Sonnet) — file management, routine updates, maintenance
- **Subagents** — delegate research reading 3+ files to subagents to protect main context

---

## Modifying CLAUDE.md

CLAUDE.md is the behavioral foundation. Modify it deliberately — it affects every session.

The main things you'd customize:

**Non-negotiable rules** — adjust the three rules at the top based on your workflow. The cost gate on Perplexity/Gemini can be loosened if you're on unlimited plans.

**Permission tiers** — add services or integrations to the Tier 1/2/3 lists.

**Pattern monitoring** — customize the patterns in `source/pattern-reference.md` to match your actual avoidance patterns. The five defaults are common among founders but may not all apply to you.

**Session deliverables** — if the ships/builds/learns framing doesn't fit your work, adapt it.

**Vault navigation** — update the path table if you rename folders or add per-spring intel.

Make one change at a time. Test it in a session. Don't refactor CLAUDE.md wholesale — small, deliberate changes only. Aim to keep it under ~150 lines.
