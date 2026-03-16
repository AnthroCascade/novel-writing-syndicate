# KB Extraction

How the syndicate builds and maintains the persistent
knowledge base.

**Preconditions:**
- Drawing forte has provided scene content for fact extraction
- Target knowledge base artefact identified (characters.md / timeline.md / continuity.md / world-rules.md)

**Postconditions:**
- Facts extracted and appended to target artefact
- No existing facts in artefact overwritten; extraction is additive
- Contradictions flagged, not silently resolved

**Invariant:**
- Knowledge base is append-only during extraction; kb-extraction does not rewrite history
- Facts extracted from manuscript; not inferred or invented

**Obligations:**
- Provides drawing forte: extracted facts with scene source reference for traceability

## Artefact structure (atomic)

The KB lives at `artefacts/` relative to the project
root. Four domains, each an **atomic folder** with
one file per entity/topic and an `_index.md`:

| Domain | Folder | Populated by |
|---|---|---|
| Characters | `characters/` | character-warden |
| Timeline | `timeline.md` | continuity-keeper |
| World rules | `world-rules/` | world-auditor |
| Continuity | `continuity/` | continuity-keeper |

### Atomic folder layout

```
artefacts/
├── characters/
│   ├── _index.md        (wikilinks to all)
│   ├── sarah.md
│   ├── chanta.md
│   └── ...
├── continuity/
│   ├── _index.md
│   ├── object-locations.md
│   ├── established-facts.md
│   ├── character-states.md
│   └── character-knowledge.md
├── world-rules/
│   ├── _index.md
│   ├── technology.md
│   ├── social-structure.md
│   ├── legal-framework.md
│   ├── geography.md
│   └── biology.md
├── arc-tracker/
│   ├── _index.md
│   └── {thread-slug}.md
├── timeline.md          (single file, small)
├── ledger.md            (single file, small)
└── staged/              (RTF staging area)
```

### Why atomic

Monolithic files grow linearly as the manuscript is
surveyed. A 500-line `characters.md` must be read
in full every time — even when only 3 characters
appear in the current scene. Atomic files let the
orchestrator read only what's relevant, saving
context window and improving accuracy.

### Selective reading protocol

When a forte needs KB context:

1. Read the relevant `_index.md` to discover
   available entries.
2. Read ONLY the atomic files for entities relevant
   to the current scope (characters in this scene,
   world-rules domains invoked, continuity sections
   needed).
3. Never read every file in a folder unless doing
   a full-manuscript audit.

A fifth artefact, `ledger.md`, is maintained by the
`/ledger` command (narrative promises). It is not
part of the KB extraction system.

A sixth, `arc-tracker/`, is maintained by the
`/ledger` command when thread-level changes are
detected. The pacing-reader forte consults it.

## Extraction stance

Record what the text establishes. Do not infer, do
not extrapolate, do not interpret ambiguity as fact.
Only record interiority or motivation the text
explicitly provides. If a fact is uncertain, do not
record it.

The KB must be as reliable as the text it derives
from.

## Output convention

Every KB-equipped forte outputs a `## KB Entries`
section at the end of its response, after its
evaluation findings. Each entry includes a scene
citation:

```
(scene: "[scene title]")
```

Omit domains or dimensions where the scene provides
nothing new.

## KB extraction mode

When a forte is fired in KB extraction mode (by
`/survey`), it outputs ONLY the `## KB Entries`
section. No evaluation, no severity grades, no
problem lists. Just fact extraction with citations.

## Deduplication

Two layers:

**Forte-side (best effort):** When a forte receives
existing KB atomic files as context, it should avoid
re-extracting facts already recorded. But fortes may
not have full context — this is advisory, not
enforced.

**Orchestrator-side (enforced):** The merge protocol
is the deduplication authority. The orchestrator
compares each KB entry against the existing atomic
file before writing. Duplicates are discarded.
Updated states replace their predecessors. This
guarantee holds regardless of whether the forte
performed its own deduplication.

## Merge protocol

The orchestrator (not the forte) persists KB entries
after collecting them. The merge is **compactive** —
new information folds into existing structure, never
appended as a second block.

### Structural targets

Each atomic file has a defined structure. The
orchestrator merges into this structure:

**`characters/{name}.md`:** One file per character.
H1 is the character name. Subsections for voice,
decisions, relationships, arc. New facts from a
later scene update the relevant subsection in
place — extending prose, adding scene citations.
A character never gets a second file — if
`sarah.md` exists, merge into it.

**`timeline.md`:** Table of events in reading order.
New events insert at the correct chronological
position, not at the bottom.

**`continuity/{section}.md`:** Each section file
contains its table. Object location rows are
**overwritten** when state changes (disc moves from
van to purse to bra — one row, current state,
latest citation). Previous locations are recorded
in the Notes column as history. Established facts
append. Character state rows update in place.

**`world-rules/{topic}.md`:** One file per domain.
Rules file under their domain heading. A rule
invoked in a new scene updates the existing entry
with the new citation, not a duplicate entry.

### Protocol

1. Collect `## KB Entries` sections from KB-equipped
   forte outputs.
2. Read relevant atomic files from `artefacts/`.
   For characters: read `characters/_index.md` to
   find existing files, then read those relevant to
   the current scene's characters.
3. For each new entry, locate its structural target:
   - **Existing entry found:** Fold new information
     into the existing text. Extend, do not replace
     wholesale — preserve what's there and add
     what's new. Append the new scene citation
     alongside existing citations.
   - **No existing entry:** Create a new atomic
     file. For characters, use a slugified filename
     (lowercase, hyphens). Update the `_index.md`
     with a new wikilink entry.
   - **State progression (object locations,
     character states):** Overwrite the current-state
     column. Move the previous state to
     history/notes.
4. **Cross-reference wikilinks (mandatory):**
   When writing or updating any atomic file, embed
   `[[slug|Display Name]]` wikilinks for every
   cross-domain reference:
   - Character names → `[[slug|Name]]`
     (e.g., `[[sarah|Sarah]]`,
     `[[chanta|Chanta]]`)
   - Arc threads → `[[slug|Name]]`
     (e.g., `[[gyges-disc|Gyges Disc]]`)
   - World-rule concepts → `[[slug|Concept]]`
     (e.g., `[[geography|Graceland]]`,
     `[[social-structure|Airborne]]`,
     `[[legal-framework|PAPER]]`)
   - **First occurrence per file** of each entity
     is sufficient — do not over-link.
   - **Never self-link** (don't link Sarah inside
     `sarah.md`).
   - These links power the Obsidian knowledge graph.
     Omitting them defeats the purpose of atomic
     files.
5. After merging, review each atomic file for
   coherence:
   - No duplicate entries within the file.
   - Citations accumulated, not replaced.
   - Reading order preserved in timeline.
   - Cross-reference wikilinks present for all
     entities mentioned.
6. Update the "Last updated" date in the affected
   atomic file(s) and the relevant `_index.md`.
7. Write updated files to `artefacts/`.
8. Report to the author:
   `KB updated: [N] new, [M] updated across [files]`

### Boundary enforcement

Each forte writes ONLY to its designated artefact
domain. The orchestrator enforces this during merge:

- Character knowledge gates, object locations, and
  character physical/professional states belong in
  `continuity/`, NOT `characters/` — even when
  extracted by character-warden during evaluation.
- Character voice, decisions, relationships, and arc
  belong in `characters/`.
- If a forte's KB entries contain data that belongs
  in another forte's artefact domain, the
  orchestrator routes it to the correct file.

This prevents bleed between artefacts regardless of
which command triggered the extraction.

## Context stratification

When firing KB-equipped fortes, pass the relevant
atomic files as additional context (read `_index.md`
first, then only relevant entries):

| Forte | KB artefact domain |
|---|---|
| continuity-keeper | `artefacts/timeline.md`, `artefacts/continuity/` |
| character-warden | `artefacts/characters/` |
| world-auditor | `artefacts/world-rules/` |
