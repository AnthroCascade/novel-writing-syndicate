# harvest

Surveys unfinished scenes by maturity and presents what each asks of the author. Readiness is recognition, not ranking — a scene in Part 5 may be ready to draft before a scene in Part 2. A garden reports on ripeness. Use this when the author wants to feel which scenes have composted enough that their voice can carry them.

## Fortes

No fortes. This is a lifecycle command that reads binder metadata and synopses to assess ripeness.

## Coordination pattern

Single pass. Walk the binder, read synopses, report what's ripe.

## Context requirements

- Scrivener project bundle
- `.scrivx` binder file for hierarchy and metadata
- `synopsis.txt` files for scenes being assessed

## Procedure

1. **Resolve scope.** Harvest works at manuscript or part scope. If no scope is provided, default to manuscript.

2. **Parse the binder.** Walk the DraftFolder. Identify scenes that are not yet at Second Draft (28) — these are the unfinished scenes.

3. **Read synopses.** For each unfinished scene, read `synopsis.txt` if it exists. This is the extent of content reading — no full scene content.

4. **Assess ripeness.** For each unfinished scene, present:
   - Title and location (Part / Chapter / Scene)
   - Current maturity (StatusID)
   - What exists (synopsis only, notes, first draft)
   - What the scene asks of the author — what decision or knowledge is needed before it can be drafted or advanced

5. **Group by what's needed.** Not by sequence or priority, but by what kind of author work each scene requires:
   - Scenes that need a decision (Blocked, Out of Place)
   - Scenes that have synopsis and could be drafted (To Do with synopsis)
   - Scenes that have rough prose and could be evaluated (First Draft)
   - Scenes with no synopsis (empty To Do — need author attention before anything)

6. **Report.** Present the harvest. The author reads and feels which ones are ripe.

## Output

Harvest report presented to the author. No files written.

## Settlement condition

The author has a clear picture of what each unfinished scene needs from them.

## Boundary

Surveys and reports. Does not rank, prioritise, or recommend. Does not evaluate scene quality. Does not draft. The author decides what to work on — the harvest gives them what they need to decide.
