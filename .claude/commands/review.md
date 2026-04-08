Run a two-stage review: fast model gap analysis → primary model counter-review.

## Step 1 — Identify review target

Look at the most recent substantive output in this conversation — the last thing you produced. This could be: a plan, a spec, a draft, a file, a proposal, a system design.

If there's one clear recent output, propose it:
"I'll review: [what]. Confirm, or tell me what to review instead."

If there are multiple recent outputs, list them and ask which one.

If the user passed arguments to this command (e.g., `/review the pricing model`), use that as the target.

Wait for confirmation before proceeding.

## Step 2 — Gap analysis (subagent)

Launch a subagent with this brief:

> You are reviewing work produced in a FonteOS vault session. The system uses Obsidian + Claude Code with optional task manager integration.
>
> Review target: [insert confirmed target — file paths, context about what was produced and why]
>
> Read the files being reviewed. Also read `/CLAUDE.md` for system rules and any referenced files needed for context.
>
> Your job: **gap analysis and improvement suggestions.** Be rigorous and critical.
>
> Cover:
> 1. **Missing elements** — anything the work should include but doesn't
> 2. **Weak coverage** — things that exist but are underserved or superficial
> 3. **Implementation risks** — things that could fail or create friction
> 4. **Structural issues** — problems with organization, flow, or architecture
> 5. **What's overengineered** — complexity without proportional value
>
> For each finding: cite the specific section/line, explain the gap, propose the fix.
> Be direct — no hedging.

Present the findings to the user.

## Step 3 — Counter-review

Review the subagent findings yourself. For each finding, state one of:

- **Agreed** — good catch, adopt as-is
- **Partially agreed** — right direction, needs adjustment (explain)
- **Disagreed** — explain why the finding is wrong or unnecessary

Also flag:
- Anything the subagent missed
- Priority ordering — which findings matter most
- Net recommendation — what to actually change

## Step 4 — Present consolidated output

```markdown
## Review: [target summary]

### Agreed findings (adopt these)
[numbered list with specific actions]

### Adjusted findings (adopt with changes)
[numbered list — subagent's point, your adjustment, final action]

### Rejected findings (skip these)
[numbered list with reasoning]

### Gaps missed
[if any]

### Priority order
[ordered list of what to change first]
```

Do not make any changes. This is a review — the user decides what to act on.
