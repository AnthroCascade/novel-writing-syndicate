# mob

Full evaluative pass against prose at any scope. Executes all 8 evaluative fortes independently. Use this when phase boundaries are unclear or you want a complete assessment. Phase-specific commands (`/evaluate`, `/polish`, `/audit`) are the norm — `/mob` is the exception.

## Fortes

| Step | Forte | Mode | Receives additionally |
|---|---|---|---|
| 1 (parallel) | scene-architect | evaluate | — |
| 1 (parallel) | character-warden | evaluate | Relevant `artefacts/characters/` files |
| 1 (parallel) | dialogue-tuner | evaluate | — |
| 1 (parallel) | continuity-keeper | evaluate | `artefacts/timeline.md`, relevant `artefacts/continuity/` files, `artefacts/ledger.md` if available |
| 1 (parallel) | pacing-reader | evaluate | `artefacts/arc-tracker/` if available |
| 1 (parallel) | voice-guardian | evaluate | — |
| 1 (parallel) | cognition-sensor | evaluate | — |
| 1 (parallel) | world-auditor | evaluate | Relevant `artefacts/world-rules/` files |

## Coordination pattern

Independent evaluation. All 8 fortes execute independently against the same static input. No forte receives another forte's spec or output. Each writes to a separate evaluation file. KB-equipped fortes (continuity-keeper, character-warden, world-auditor) also output `## KB Entries` sections. The orchestrator persists KB entries per the merge protocol after evaluation completes.

## Context requirements

Before fortes fire:

- Scene/chapter/part content (from Scrivener via scrivener-nav)
- Synopsis and notes for target scenes
- Adjacent scene synopses (for continuity context)
- Each forte's spec and all talents from its "Draws on" section
- Relevant KB artefact files per context stratification (read `_index.md` first, then only entries relevant to current scope)

## Procedure

1. **Resolve scope.** Parse the Scrivener binder and locate the target. If no scope is provided, ask.

2. **Check maturity.** Read each scene's StatusID. Adapt forte selection: at To Do (1), only scene-architect and continuity-keeper fire against the synopsis. At First Draft (2), lighter evaluation — voice-guardian and cognition-sensor are less relevant. At Second Draft (28), full evaluation.

3. **Read content.** Convert RTF to text via scrivener-nav. Read synopsis and notes. Read adjacent scene synopses for context.

4. **Load KB context.** For each KB-equipped forte, read the relevant `_index.md` and only the atomic files for entities in the current scope.

5. **Fire all evaluative fortes independently.** Each fires in its own Agent call with: its spec, its resolved talents, scene content, and any forte-specific KB context per the table above.

6. **Collect evaluation outputs.** Write each to `artefacts/evaluations/forte-[name].md`.

7. **Persist KB entries.** Collect `## KB Entries` sections from KB-equipped fortes. Merge per kb-extraction protocol.

8. **Present to author.** Which fortes fired, key findings, evaluation file locations. The forte files are the evaluation — no synthesis.

## Output

- `artefacts/evaluations/forte-scene-architect.md`
- `artefacts/evaluations/forte-character-warden.md`
- `artefacts/evaluations/forte-dialogue-tuner.md`
- `artefacts/evaluations/forte-continuity-keeper.md`
- `artefacts/evaluations/forte-pacing-reader.md`
- `artefacts/evaluations/forte-voice-guardian.md`
- `artefacts/evaluations/forte-cognition-sensor.md`
- `artefacts/evaluations/forte-world-auditor.md`
- KB artefact updates (if KB entries produced)

## Settlement condition

All engaged forte evaluation files are written. KB entries persisted.

## Boundary

Evaluates. Does not draft, revise, or restructure. The forte files are the evaluation — no synthesis files. Author decides what to act on. With forte selection by the author, `/mob` with specific fortes is equivalent to the corresponding phase command. Phase-specific invocations are the norm; `/mob` is the exception.
