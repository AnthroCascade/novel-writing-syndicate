# map

Parses the Scrivener binder and reports maturity per scene, grouped by readiness. Structural reconnaissance — no content is read, no fortes fire, no evaluation happens. Use this to get a manuscript-wide dashboard of what exists and what state it is in.

## Fortes

No fortes. This is a navigation command that reads binder metadata only.

## Coordination pattern

Single pass. Parse the binder XML once and report.

## Context requirements

- Scrivener project bundle (`.scriv` directory)
- `.scrivx` binder file for hierarchy and metadata

## Procedure

1. **Locate the Scrivener project.** Find the `.scriv` bundle in the project directory.

2. **Parse the binder.** Read the `.scrivx` XML. Walk the DraftFolder and all descendants. For each item, extract: UUID, Type (Folder/Text), Title, LabelID (Part/Chapter/Scene/Sequel/Idea/Notes/Character/Narrative), StatusID (To Do/First Draft/Second Draft/Blocked/Out of Place/Deferred/Incorporated/Backstory), IncludeInCompile.

3. **Build the hierarchy.** Map the Part → Chapter → Scene tree. Count scenes per chapter, chapters per part.

4. **Group by readiness.** Report scenes grouped by StatusID:
   - **To Do (1)** — outline only, synopsis may exist
   - **First Draft (2)** — rough prose exists
   - **Second Draft (28)** — drafted prose, ready for evaluation
   - **Blocked (26)** — needs author decision
   - **Out of Place (32)** — displaced, needs assessment
   - **Deferred for 2nd Draft (29)** — set aside
   - **Incorporated in 2nd Draft (30)** — absorbed into other scenes
   - **Backstory (31)** — reference material

5. **Report.** Present the maturity dashboard: total scenes, scenes per status, scenes per part/chapter. Highlight any structural anomalies (empty chapters, chapters with a single scene, parts with no Second Draft scenes).

## Output

Maturity dashboard presented to the author. No files written — this is a read-only status report.

## Settlement condition

Maturity report delivered for the full manuscript.

## Boundary

Metadata only. Does not read scene content, does not evaluate, does not modify anything. For content reading, use `/read`. For content evaluation, use `/explore` or `/evaluate`.
