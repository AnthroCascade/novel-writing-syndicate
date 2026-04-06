# survey

Walks scenes extracting facts to the persistent knowledge base. Fires continuity-keeper, character-warden, and world-auditor in KB extraction mode — fact extraction only, no evaluation, no severity grades, no problem lists. Use this to systematically populate the KB before running evaluation passes.

## Fortes

| Step | Forte | Mode | Receives additionally |
|---|---|---|---|
| 1 (parallel, per scene) | continuity-keeper | KB extraction | Existing `artefacts/timeline.md`, relevant `artefacts/continuity/` files |
| 1 (parallel, per scene) | character-warden | KB extraction | Relevant `artefacts/characters/` files |
| 1 (parallel, per scene) | world-auditor | KB extraction | Relevant `artefacts/world-rules/` files |

## Coordination pattern

Sequential scene walk with parallel forte execution per scene. For each scene in the scope, all three KB-equipped fortes fire in parallel in extraction mode. The orchestrator merges entries after each scene before proceeding to the next.

## Context requirements

Before fortes fire for each scene:

- Scene content (from Scrivener via scrivener-nav)
- Each forte's spec and all talents from its "Draws on" section
- `talents/kb-extraction.md` — the KB protocol
- Existing KB artefact files relevant to the current scene (read `_index.md` first, then relevant entries — for deduplication)

## Procedure

1. **Resolve scope.** Survey works at chapter or part scope. Parse the Scrivener binder.

2. **Read existing KB.** Read `_index.md` files in `artefacts/characters/`, `artefacts/continuity/`, and `artefacts/world-rules/`. This establishes what's already recorded for deduplication.

3. **Walk scenes in reading order.** For each scene:
   - Read scene content (convert RTF to text)
   - Fire all three fortes in parallel, each in KB extraction mode
   - Collect `## KB Entries` sections from each forte
   - Merge entries into the KB per the merge protocol: fold into existing structure, no duplicates, state progressions overwrite, cross-reference wikilinks maintained, `_index.md` updated
   - Report progress: `Surveyed: [scene title] — [N] new, [M] updated entries`

4. **Final report.** Total entries: new, updated, unchanged. Files modified. Any observations about KB completeness gaps.

## Output

- Updated KB artefact files:
  - `artefacts/characters/{name}.md` (one per character)
  - `artefacts/timeline.md`
  - `artefacts/continuity/{section}.md`
  - `artefacts/world-rules/{topic}.md`
  - All relevant `_index.md` files

## Settlement condition

All scenes in scope surveyed. KB entries merged. No extraction output lost.

## Boundary

Extraction only. No evaluation, no problem lists, no severity grades. The survey records what the text establishes — it does not judge it. For evaluation, use `/evaluate` or `/mob` after the KB is populated.
