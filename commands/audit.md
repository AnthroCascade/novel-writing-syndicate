# audit

Fires continuity-keeper and world-auditor to check cross-scene consistency within a chapter, part, or manuscript. Use this after scenes have been drafted and evaluated individually, to catch contradictions that only become visible when scenes are read together.

## Fortes

| Step | Forte | Mode | Receives additionally |
|---|---|---|---|
| 1 (parallel) | continuity-keeper | audit | `artefacts/timeline.md`, relevant `artefacts/continuity/` files, `artefacts/ledger.md` if available |
| 1 (parallel) | world-auditor | audit | Relevant `artefacts/world-rules/` files |

## Coordination pattern

Parallel evaluation. Both fortes fire concurrently. Each checks consistency across the full scope — not individual scenes, but the relationships between them.

## Context requirements

Before fortes fire:

- All scene content within the scope (from Scrivener via scrivener-nav)
- Adjacent scope content (scenes bordering the audited range)
- Each forte's spec and all talents from its "Draws on" section
- Relevant KB artefact files (read `_index.md` first, then relevant entries)

## Procedure

1. **Resolve scope.** Parse the Scrivener binder and locate the target. Audit works at chapter, part, or manuscript scope. Scene scope is too narrow for cross-scene consistency — redirect to `/evaluate` if attempted.

2. **Read all content within scope.** Convert RTF to text for every scene in the target. Read synopses for adjacent scenes outside the scope.

3. **Load KB context.** Read relevant atomic KB files for both fortes.

4. **Fire both fortes in parallel.** Continuity-keeper checks all continuity domains (timeline, character knowledge gates, character state, technology, geography, object tracking, established rules, narrative promises) across scenes. World-auditor checks that world rules are applied consistently — same technology works the same way, social structures are consistent, geography is accurate.

5. **Collect outputs.** Write to `artefacts/evaluations/forte-[name].md`.

6. **Persist KB entries.** Merge per kb-extraction protocol.

7. **Present to author.** Cross-scene contradictions with severity grades (hard break, soft break, gap, drift for world-auditor). Each finding cites both source scenes. Neither forte proposes fixes — the author may be revising canon.

## Output

- `artefacts/evaluations/forte-continuity-keeper.md`
- `artefacts/evaluations/forte-world-auditor.md`
- KB artefact updates (if KB entries produced)

## Settlement condition

No internal contradictions at scope — or all contradictions identified with severity grades and source citations.

## Boundary

Cross-scene consistency only. Does not evaluate individual scene quality (that is `/evaluate`), voice (that is `/polish`), or pacing (that is `/evaluate` at chapter/part scope). Does not fix contradictions — the author decides canon.
