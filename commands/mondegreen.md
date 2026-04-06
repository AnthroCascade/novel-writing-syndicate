# mondegreen

Generates chapter title candidates as "Suspicious Minds" mondegreens — mishearings of the Elvis Presley song, repurposed as chapter titles that resonate with the chapter's content. The novel's Elvis connection makes this the title convention.

## Fortes

No fortes. This is a specialised generation task at orchestrator level.

## Coordination pattern

Single action. Read the chapter, generate candidates, present.

## Context requirements

- Chapter content (from Scrivener via scrivener-nav) — to understand what the chapter is about
- Existing chapter titles (from binder) — to avoid repetition

## Procedure

1. **Resolve scope.** The author specifies a chapter. Parse the Scrivener binder.

2. **Read chapter content.** Understand the chapter's themes, events, key moments, and emotional arc.

3. **Read existing titles.** Collect all existing chapter titles from the binder to avoid duplication.

4. **Generate candidates.** Produce mondegreen candidates — mishearings of "Suspicious Minds" (or broader Elvis catalogue where relevant) that work as chapter titles. Each candidate should:
   - Sound plausibly like a mishearing of the source lyric
   - Resonate with the chapter's content, theme, or key moment
   - Work as a standalone title (a reader who doesn't know the game still gets a title)

5. **Present with rationale.** For each candidate: the title, the source lyric, and a one-sentence note on how it connects to the chapter.

## Output

Title candidates presented to the author. No files written — the author chooses and applies.

## Settlement condition

Candidates presented. The author picks or rejects.

## Boundary

Title generation only. Does not evaluate the chapter, restructure it, or modify the binder. The author applies the chosen title to Scrivener.
