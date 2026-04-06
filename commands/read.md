# read

Displays scene, chapter, or part content from the Scrivener project. Read-only — no evaluation, no modification, no fortes. Use this to load content into the conversation for reference, or to review what exists before deciding what to do.

## Fortes

No fortes. This is a navigation command.

## Coordination pattern

Single action. Resolve scope, read content, present.

## Context requirements

- Scrivener project bundle
- `.scrivx` binder file for scope resolution

## Procedure

1. **Resolve scope.** The author specifies: `scene [title]`, `chapter [title]`, or `part [title]`. Parse the Scrivener binder and locate the target via title matching (case-insensitive, partial matches when unambiguous).

2. **Read content.** For each scene in scope:
   - Convert `content.rtf` to plain text via `textutil -convert txt -stdout`
   - Strip Scrivener formatting markers (`<$Scr_...>` patterns)
   - Read `synopsis.txt` if it exists
   - Read `notes.rtf` if it exists (convert to text)

3. **Present.** Display content with clear scene boundaries. For chapter or part scope, present scenes in binder order with titles as headings. Include synopsis and notes when they exist, clearly labelled.

4. **Report metadata.** For each scene: title, StatusID (maturity), LabelID (type), IncludeInCompile. At chapter/part scope: scene count, maturity distribution.

## Output

Content displayed in conversation. No files written.

## Settlement condition

Requested content is displayed with metadata.

## Boundary

Read-only. Does not evaluate, modify, or write. Does not fire fortes. For evaluation after reading, use `/evaluate`, `/polish`, or `/mob`. For structural reconnaissance, use `/explore`.
