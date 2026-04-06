# draft

Fires prose-scribe to draft scene prose in the author's voice, with a convergence loop of up to 3 passes. Each pass drafts, then evaluative fortes assess, then the drafter incorporates feedback. Use this when a scene is ready to write — composted, harvested, and the author knows what it needs to do.

## Fortes

| Step | Forte | Mode | Receives additionally |
|---|---|---|---|
| 1 | prose-scribe | draft | Synopsis, notes, adjacent scene content, author direction, prior evaluations if any |
| 2 (convergence) | voice-guardian | evaluate | Produced draft |
| 2 (convergence) | cognition-sensor | evaluate | Produced draft |
| 3 (convergence) | prose-scribe | revision | Voice-guardian and cognition-sensor findings |

Steps 2–3 repeat up to 3 iterations or until fortes are satisfied.

## Coordination pattern

Convergence loop. Prose-scribe drafts. Voice-guardian and cognition-sensor evaluate the draft. Prose-scribe incorporates feedback and redrafts. Loop continues until evaluative fortes find no actionable issues or 3 iterations are reached. After 3 iterations, present remaining issues to the author for decision.

## Context requirements

Before prose-scribe fires:

- Scene synopsis (from `synopsis.txt`)
- Scene notes (from `notes.rtf`, if exists)
- Adjacent scene content (for continuity and voice reference)
- Author direction (from the command invocation)
- Prior evaluations (if scene was previously evaluated)
- Prose-scribe forte spec and all talents from its "Draws on" section
- Voice-guardian and cognition-sensor forte specs and talents (for convergence steps)

## Procedure

1. **Resolve scope.** Parse the Scrivener binder and locate the target scene. Drafting operates at scene scope only — one scene at a time.

2. **Check maturity.** Read the scene's StatusID. If To Do (1), the scene has only synopsis — draft from synopsis and notes. If First Draft (2) or later, a draft exists — confirm whether the author wants a fresh draft or revision.

3. **Read inputs.** Scene synopsis, notes, adjacent scene content. Read any prior evaluations in `artefacts/evaluations/`.

4. **Fire prose-scribe.** Pass: forte spec, resolved talents, scene inputs, author direction. Voice markers are active constraints during generation. Kill list items are filtered before output. The drafter produces one scene and pauses.

5. **Present draft to author.** The author accepts or requests changes. If accepted, proceed to convergence. If changes requested, incorporate and re-present before entering the convergence loop.

6. **Convergence loop (max 3 passes).** Fire voice-guardian and cognition-sensor against the draft. If they find actionable issues, fire prose-scribe in revision mode to incorporate feedback. Repeat until clean or 3 iterations reached.

7. **Present final draft.** Report convergence outcome: how many passes, what was addressed, any remaining flags.

## Output

- Drafted scene prose (presented to author, written to Scrivener staging or artefacts as appropriate)
- Convergence evaluation files from each pass

## Settlement condition

Author accepts the draft, or 3 convergence iterations are exhausted and remaining issues are presented for author decision.

## Boundary

Drafts one scene at a time. Does not evaluate structure, character, continuity, or pacing — those are `/evaluate` and `/mob`. Does not draft entire chapters in one pass. Does not continue drafting when uncertain — pauses and asks.
