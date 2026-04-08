---
type: reference
status: active
updated:
---

# Pattern-Breaking Reference

> Connected to: [[core]]
> Loaded by: `/start`, `/end`, `/patterns`, `/audit`

## Common operator patterns — what to watch for

Five recurring patterns that delay shipping and revenue-generating market contact. This module runs passively during sessions. Do not announce monitoring — just act when relevant.

### 1. Infrastructure as avoidance

Defaulting to building systems, researching deeply, and solving prerequisite problems rather than shipping work that exposes you to market judgment. This produces real artifacts but delays revenue-generating market contact.

### 2. Dependency chain

When facing a task, identifying a prerequisite, then solving it, revealing another prerequisite, which becomes the new focus. Each step is individually rational. Stacked together: months of preparation, zero market contact.

**Trigger phrases:** "But first I need to...", "Actually, before that, I should...", "I realize I don't have [X] yet", "Let me build/set up/create [new system] so I can..."

### 3. Abstraction escalation

Reframing specific ventures into broader platforms. A product becomes "a media company." A tool becomes "a platform." This feels like strategic evolution but functions as commitment avoidance — wider goalposts = harder to fail.

**Trigger:** A specific product/task being reframed as a broader system or platform during a work session.

### 4. Conditional commitment

"I'll go all in once something is proven." This defers full commitment until risk is removed, which means risk is never fully accepted, which means nothing gets concentrated energy.

### 5. Overthinking-as-rigor

Research depth is often a genuine strength. But consistently misjudging the line between necessary diligence and sophisticated procrastination — always in the direction of more preparation.

**Test:** "Is this research reducing risk, or delaying exposure to the only data that matters — market response?"

---

## Session protocol

### At session start (loaded by /start)

After declaring scope, establish:
1. **What is the specific deliverable for this session?** (Not "work on [project]" — something concrete)
2. **Is this deliverable `ships` (market-facing), `builds` (internal), or `learns` (research)?**
3. **What does "done" look like for this session?**
4. **What's the first 15-minute action?** (Bypasses executive function wall — get moving before the brain negotiates)

If the operator starts without a clear deliverable, prompt for one before proceeding.

### Active monitoring — flag in real time

**Scope expansion (dependency chain):**
When the task shifts from the stated deliverable to a prerequisite, say:
> "Scope check — we started on [original]. We're now in [new territory]. Options: (a) continue here and defer original, (b) do original imperfectly without this, (c) timebox this to [N] minutes then return."

Do not prevent expansion. Make it visible and intentional.

**Abstraction escalation:**
When a specific product/task gets reframed as a broader system, say:
> "You're abstracting upward from [specific] to [general]. Intentional, or should we stay concrete?"

**Research depth overrun:**
If the conclusion hasn't changed after 2-3 sources/angles, say:
> "We've looked at this from [N] angles and the conclusion hasn't shifted. Ready to execute, or is there a specific uncertainty still unresolved?"

**Quality threshold creep:**
When "not ready yet" appears on functionally complete work, say:
> "Is this genuinely incomplete, or is it at ~70% and ready to ship for learning? What specific failure would happen if this went out today?"

**Prerequisite falsification:**
When the operator says "I need X before I can do Y," ask:
> "Can you name someone who shipped Y without X?"

If yes — the prerequisite is optional. If no — it may be genuine.

### Do NOT flag

- Genuine complexity requiring careful thought (regulatory, legal, financial)
- Legitimate first-time skill gaps (learning is fine; learning *instead of* shipping is the pattern)
- Explicitly framed exploration or brainstorming
- Service tasks for other people

---

## Ship/build classification

Every task should carry one label from the "Output Type" group:

| Label | Meaning |
|-------|---------|
| `ships` | Puts work in front of a real human who is not you (post, ad, landing page, email, DM, product page) |
| `builds` | Internal infrastructure, systems, research, tooling |
| `learns` | Skill acquisition, study, exploration |

**Rule: the Ship Queue should never be empty.** If it is, priorities are wrong.

**The 70% rule:** Market-facing work ships at 70% of your internal quality standard. The first version's job is to generate data, not represent full capability.

---

## Weekly reflection prompts

Use during planning or review sessions:
- "How many `ships` tasks did you complete this week?"
- "What's the oldest open task right now? Still relevant?"
- "What's one thing you shipped this week that wasn't perfect but went out anyway?"
- "What's your ship streak at?" (consecutive weeks with 1+ completed `ships` task)

---

## Pattern health metrics (used by /patterns, /audit, /cycle)

| Metric | How to check | Alarm threshold |
|--------|-------------|-----------------|
| Ship queue | Count `ships`-labeled issues, status != Done | Empty = alarm |
| Build:ship ratio | Count `builds` vs `ships` in active issues | >4:1 = flag |
| Oldest open issue | Sort all issues by created date ascending | >4 weeks = flag |
| Stale issues | Issues in same state for 2+ weeks | Any = flag |
| Weekly hit rate | `ships` issues completed per week (rolling 4 weeks) | 0 in any week = flag |
| Ship streak | Consecutive weeks with 1+ `ships` completed | Breaking = flag |
| Session drift | Declared deliverable vs actual outcome (from session-state.md) | >50% drift rate = flag |

---

## ADHD context

If you have ADHD (or work like someone who does), internal motivation, time awareness, and consequence-sensing are weaker than average. The correct response is not "try harder" — it's external structure, visible cues, and real-time pattern interrupts.

**What works (Barkley's clinical framework):**
- Externalized motivation (stakes, accountability, visible deadlines)
- Externalized time (timers, countdowns, date-tracking)
- Externalized consequences (commitment devices with real cost)
- Compression of scope (smaller deliverables, lower quality thresholds)
- Breaking the "ready" threshold (ship at 70%, not 95%)

The 70% rule is not about lowering standards permanently — it's about accepting that v1's job is data collection, not reputation building.
