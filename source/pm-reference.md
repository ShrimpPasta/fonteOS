---
type: reference
status: active
updated:
---

# PM Integration Reference

> Connected to: [[core]]

Reference file for task management integration. Used by `/start`, `/end`, `/cycle`, `/audit` commands. Only loaded when commands need PM context.

## Architecture

**Two views, one system.** The vault (springs, streams, intelligence) is the strategic layer — direction, context, knowledge. Your task manager is the execution layer — issues, priorities, status. Both are authoritative in their domain. They stay in sync through `/start`, `/end`, `/audit`, and `/cycle`.

**"Todo"/"Now" is the shared execution surface.** Move issues/tasks there when they're ready. The agent processes only these. This is the handshake: human sets priority, agent executes or proposes.

**Move to "In Progress" on pickup.** When Claude begins working on an issue — whether in an interactive session or during `/cycle` — immediately move it to "In Progress." This is autonomous (Tier 1).

**Project = spring.** Each task manager project maps to exactly one vault spring. The mapping lives in `source/stream-mapping.yaml`.

**Agent comment prefix.** All comments posted by Claude must start with a clear agent identifier (e.g., "Agent:") followed by the content.

**Verify after mutating.** After creating or updating issues, always fetch back to confirm the change succeeded.

## How the task manager enriches workflows

- `/start` — pulls "Todo" issues per project, shows them alongside stream status when suggesting work
- `/end` — proposes issue updates (completion, comments) alongside vault upstreams
- `/audit` — checks for drift between vault streams and task manager issues
- `/cycle` — automated daily scan of all projects, classification, and reporting

## Labels (agent workflow)

| Label | Meaning |
|-------|---------|
| `agent-pending` | Agent output needs human review |
| `agent-approved` | Human approved, agent executes next cycle |
| `agent-blocked` | Agent can't proceed, needs human input |
| `human-only` | Agent should not touch this issue |

## Output Type labels (pattern-breaking system)

Every issue should carry one label: `ships`, `builds`, or `learns`. See `source/pattern-reference.md` for definitions.

**Auto-labeling rules:**
- Keywords like "post", "publish", "launch", "send", "landing page", "website", "profile", "social" → `ships`
- Keywords like "set up", "configure", "research", "system", "schema", "pipeline", "plan", "define" → `builds`
- Keywords like "research", "explore", "study", "learn", "investigate" → `learns`
- If ambiguous, default to `builds`
- Existing labels are preserved — never overwrite a human-applied label

## Decision template

Use when surfacing an NH (Needs Human) decision:

```
DECISION REQUIRED — [topic]
Context: [1-2 lines]
Options: A. / B. / C.
Trade-offs: [2-3 lines]
Recommendation: [X] because [one sentence]
→ Reply to proceed.
```

## Stream mapping schema

Create `source/stream-mapping.yaml` to map task manager projects to vault springs:

```yaml
# For Linear:
projects:
  my-project:
    id: "project-uuid"
    name: "My Project"
    spring_index: "springs/my-project/my-project_index.md"
    content_dir: "springs/my-project/content/"
    context_files:
      - springs/my-project/my-project_index.md
    extra_context_by_keyword:
      content:
        - intelligence/voice.md

# For Asana:
projects:
  my-project:
    project_gid: "1234567890"
    now_section_gid: "0987654321"
    spring_index: "springs/my-project/my-project_index.md"
    context_files:
      - springs/my-project/my-project_index.md
```

The `context_files` list tells the cycle what to load before working on tasks from that project.
