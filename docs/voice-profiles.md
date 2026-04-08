# Voice Profiles

How to build an intelligence file that makes Claude write like you — not like an AI approximation of you.

---

## What a voice profile is

A voice profile is an intelligence file that captures how you actually write and think. Not your positioning. Not your brand pillars. Your actual voice — the patterns, beliefs, rhythms, and hard limits that make your content sound like you rather than a generic AI output.

Without a voice profile, Claude writes serviceable prose that matches your instructions but not your sensibility. With one, it writes drafts that sound like you at your best — which you then refine rather than rewrite from scratch.

A voice profile lives at `intelligence/voice.md`. It's loaded before any content generation work.

---

## Structure

```markdown
---
type: intelligence
confidence: high
tags: [voice, content]
updated: YYYY-MM-DD
---

# Voice Profile — [Your Name]

> **Confidence:** High
> Connected to: [[core]]

## Core Identity

Who you are, what you're building, and how you communicate. Your background,
your operating context, the lens you bring to your work. 2-3 paragraphs.

## Beliefs & Contrarian Takes

Q&A format. The questions that reveal your actual opinions. What do you believe
that most people in your field disagree with? Where is the consensus wrong?

Include 5-10 questions with your real answers.

## Writing Mechanics

How you write first drafts:
- Sentence length and rhythm
- Words you reach for vs. words you avoid
- How you open, how you handle transitions
- Your relationship with data and evidence

Include 2-3 example sentences that sound like you.

## Aesthetic Crimes

What triggers your bullshit detector:
- The worst patterns in content in your space
- Phrases that signal someone isn't thinking
- What "trying too hard" looks like

This section is as important as the positive voice cues.

## Voice & Personality

What you sound like when people lean in. Your humor style. How you handle
vulnerability. How you handle being wrong.

## Structural Preferences

How you organize content — pacing, structure, length, complexity handling.

## Hard Nos

Non-negotiables. Content you would refuse to produce even if it drove growth.
Be specific.

## Quick Reference Card

Always:
- [5-7 rules]

Never:
- [5-7 anti-patterns]

## Instructions for Claude

1. Load this file before any content drafting task.
2. First draft should feel like [your name] wrote it.
3. If the brief conflicts with voice principles, flag it.
4. Hard Nos are hard stops.
5. After drafting: check against Aesthetic Crimes.
6. Spirit over letter.
```

---

## How to build it

Don't write this file yourself. Interview it out with Claude.

**Step 1 — Start the interview**

```
I want to build a voice profile intelligence file. Interview me — ask me
questions about how I write, what I believe, what I hate in content,
and what I sound like at my best. One question at a time.
Don't summarize until I say I'm done.
```

**Step 2 — Answer honestly**

Claude will ask questions like:
- "What's a piece of writing you've done that felt most like you?"
- "What do you see in other content in your space that makes you cringe?"
- "What's a belief you hold that your peers would push back on?"

Answer in stream of consciousness. Don't optimize.

**Step 3 — Crystallize**

After 20-30 minutes of Q&A, tell Claude to crystallize the answers into the voice profile structure. Review it. Push back on anything that doesn't sound right.

**Step 4 — Test it**

Ask Claude to write a short piece using the voice profile. Compare it to something you've actually written. Identify the gaps. Refine.

This is an ongoing artifact — update it as your voice evolves.

---

## How it's used in sessions

Any session involving content should load the voice profile first:

```
Load intelligence/voice.md before we start drafting.
```

Or build a content agent (see [customization.md](customization.md)) that includes "load voice.md first" as step one.

The voice profile is most powerful when combined with a humanize skill run after drafting. The voice file gives Claude your patterns; the humanize skill removes the AI patterns. Together, drafts need revision, not reconstruction.

---

## What good looks like

A good voice profile passes three tests:

1. **The recognition test** — someone who knows your writing reads a Claude-generated draft with no attribution. They'd say it sounds like you.
2. **The anti-pattern test** — the Aesthetic Crimes section is specific enough that Claude can identify violations, not just "this doesn't sound right."
3. **The hard no test** — if you ask Claude to violate your Hard Nos, it stops and says why.

If it doesn't pass all three, keep refining. The investment compounds.
