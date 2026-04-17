# evaluate

Fires the five storytelling fortes to assess whether the scene works as storytelling — structure, character, dialogue, continuity, and pacing. Use this after drafting to identify craft-level issues before polishing voice.

## Fortes

| Step | Forte | Mode | Receives additionally |
|---|---|---|---|
| 1 (parallel) | scene-architect | evaluate | — |
| 1 (parallel) | character-warden | evaluate | Relevant `artefacts/characters/` files |
| 1 (parallel) | dialogue-tuner | evaluate | — |
| 1 (parallel) | continuity-keeper | evaluate | `artefacts/timeline.md`, relevant `artefacts/continuity/` files, `artefacts/ledger.md` if available |
| 1 (parallel) | pacing-reader | evaluate | `artefacts/arc-tracker/` if available |

## Coordination pattern

Independent evaluation. All five fortes execute independently against the same static input. No forte receives another forte's output. KB-equipped fortes (continuity-keeper, character-warden) also output `## KB Entries` sections.

## Context requirements

Before fortes fire:

- Scene/chapter/part content (from Scrivener via scrivener-nav)
- Synopsis and notes for target scenes
- Adjacent scene synopses (for continuity and pacing context)
- Each forte's spec and all talents from its "Draws on" section
- Relevant KB artefact files per context stratification

## Procedure

1. **Resolve scope.** Parse the Scrivener binder and locate the target. Evaluate works at scene, chapter, or part scope. At chapter scope, pacing-reader assesses scene-to-scene rhythm. At part scope, pacing-reader assesses chapter-to-chapter escalation.

2. **Check maturity.** At To Do (1), only scene-architect and continuity-keeper fire against the synopsis. At First Draft (2), all five fire with lighter evaluation — structure and character fortes are primary. At Second Draft (28), full evaluation.

3. **Read content.** Convert RTF to text. Read synopsis and notes. Read adjacent scene synopses.

4. **Load KB context.** Read relevant atomic KB files for KB-equipped fortes.

5. **Fire all five fortes independently.** Each fires in its own Agent call with: its spec, resolved talents, scene content, and forte-specific KB context per the table above.

6. **Collect outputs.** Write to `artefacts/evaluations/forte-[name].md`.

7. **Persist KB entries.** Merge per kb-extraction protocol.

8. **Present to author.** Which fortes fired, key findings, evaluation file locations. Each forte asks at least one hard craft question per its editorial stance. The forte files are the evaluation.

## Output

- `artefacts/evaluations/forte-scene-architect.md`
- `artefacts/evaluations/forte-character-warden.md`
- `artefacts/evaluations/forte-dialogue-tuner.md`
- `artefacts/evaluations/forte-continuity-keeper.md`
- `artefacts/evaluations/forte-pacing-reader.md`
- KB artefact updates (if KB entries produced)

## Settlement condition

Scene works as storytelling — all five fortes have filed their assessments and craft questions.

## Boundary

Evaluates storytelling craft. Does not assess voice (that is `/polish`), does not draft or revise (that is `/draft` and `/revise`), does not check cross-scene consistency beyond the given scope (that is `/audit`).
