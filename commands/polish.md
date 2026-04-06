# polish

Fires voice-guardian and cognition-sensor to protect voice and detect AI tells. Use this after the scene works structurally (post-evaluate) to ensure the prose sounds like the author, not like competent MFA workshop fiction.

## Fortes

| Step | Forte | Mode | Receives additionally |
|---|---|---|---|
| 1 (parallel) | voice-guardian | evaluate | — |
| 1 (parallel) | cognition-sensor | evaluate | — |

## Coordination pattern

Parallel evaluation. Both fortes fire concurrently. Voice-guardian checks voice markers (positive and negative), character voice signatures, the kill list, and the 12 "never change" rules. Cognition-sensor applies the kill list and both lenses (Another Consciousness, Costly Cognition) from the cognition-sensing talent.

## Context requirements

Before fortes fire:

- Scene/chapter content (from Scrivener via scrivener-nav)
- Each forte's spec and all talents from its "Draws on" section

## Procedure

1. **Resolve scope.** Parse the Scrivener binder and locate the target. Polish works at scene or chapter scope.

2. **Check maturity.** At To Do (1) or First Draft (2), voice polishing is premature — the prose is still settling. Report this and ask the author whether to proceed. At Second Draft (28), full evaluation.

3. **Read content.** Convert RTF to text.

4. **Fire both fortes in parallel.** Voice-guardian applies three silent reads, then the problem list protocol (max 15 per scene), the red flag test, and the lens check. Cognition-sensor reads once for content, once for slop (assume AI-generated and search for evidence otherwise), and a third time for costly cognition.

5. **Collect outputs.** Write to `artefacts/evaluations/forte-[name].md`.

6. **Present to author.** Voice-guardian findings with exact quotes and the "necessary not better" filter. Cognition-sensor flags with exact quotes and slop categories. Both fortes default to PRESERVE when uncertain.

## Output

- `artefacts/evaluations/forte-voice-guardian.md`
- `artefacts/evaluations/forte-cognition-sensor.md`

## Settlement condition

Voice is clean, no AI tells. Both fortes have filed their assessments.

## Boundary

Voice protection and AI-tell detection only. Does not evaluate structure, character, continuity, or pacing (that is `/evaluate`). Does not fix — detection only. The author decides what to act on; `/revise` applies corrections.
