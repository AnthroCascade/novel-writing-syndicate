# revise

Fires prose-scribe in correction mode to apply known, approved fixes to existing prose. Use this after evaluation has identified issues and the author has approved corrections. Minimum alteration. Zero additions, zero "while I'm here" improvements.

## Fortes

| Step | Forte | Mode | Receives additionally |
|---|---|---|---|
| 1 | prose-scribe | revision | Approved corrections, current scene prose |

## Coordination pattern

Single-agent. Prose-scribe receives the current prose and the list of approved corrections. It applies each correction with the minimum alteration necessary and produces a change log.

## Context requirements

Before prose-scribe fires:

- Current scene prose (from Scrivener via scrivener-nav)
- Approved corrections (from evaluation files or author direction)
- Prose-scribe forte spec and all talents from its "Draws on" section
- Adjacent scene content (for continuity reference)

## Procedure

1. **Resolve scope.** Parse the Scrivener binder and locate the target scene. Revise operates at scene scope.

2. **Read current prose.** Convert RTF to text.

3. **Confirm corrections.** Present the corrections to be applied. If no approved corrections exist, ask the author what to fix. Unapproved corrections are not applied.

4. **Fire prose-scribe in revision mode.** Pass: forte spec (revision mode section), resolved talents, current prose, approved corrections. Voice markers are active constraints. The scribe applies each correction with minimum alteration. No additions. No improvements beyond what was approved.

5. **Present revised prose with change log.** Every change accounted: paragraph number, before/after quotes, type (typo/continuity/compression/approved-fix), reason. Word count shift exceeding 50 words requires explanation.

6. **Smart quotes verification.** All dialogue uses curly double quotes. Nested quotes use curly single quotes. No straight quotes. Verified before presenting.

## Output

- Revised scene prose with change log
- Word count comparison (before/after)

## Settlement condition

All approved corrections applied. Change log complete. No unapproved modifications.

## Boundary

Applies known fixes. Does not evaluate, does not rewrite, does not improve. If the prose needs more than surgical correction, use `/draft` instead. Does not apply corrections the author has not approved.
