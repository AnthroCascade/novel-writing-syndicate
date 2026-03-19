# Scrivener Navigation

## Domain

Reading and navigating Scrivener 3 project bundles.
Understanding the binder structure, locating scene
content, interpreting metadata.

## Optimises for

Accurate, efficient access to the right content at
the right scope.

## Bundle structure

A Scrivener 3 project is a directory bundle:

```
[Project].scriv/
  [Project].scrivx        -- XML binder (hierarchy)
  Files/
    Data/
      [UUID]/
        content.rtf        -- scene/folder body text
        content.styles     -- RTF styling metadata
        synopsis.txt       -- scene synopsis (plain text)
        notes.rtf          -- scene notes (RTF)
  Settings/                -- compile and project settings
  Snapshots/               -- versioned snapshots
```

## Binder hierarchy

The `.scrivx` file is XML. The relevant section is
the `<Binder>` element containing nested
`<BinderItem>` elements. Each has:

- `UUID` attribute — unique identifier, maps to
  `Files/Data/{UUID}/`
- `Type` attribute — `DraftFolder`, `Folder`, `Text`
- `<Title>` — display name
- `<Children>` — nested items
- `<MetaData>` containing `<LabelID>`, `<StatusID>`,
  `<IncludeInCompile>`, `<SectionType>`

The Manuscript is the `DraftFolder` type BinderItem.

## "Clones of Elvis" binder conventions

### Hierarchy

```
Manuscript (DraftFolder)
  Part (Folder)       -- top-level folders in Manuscript
    Chapter (Folder)  -- sub-folders within Parts
      Scene (Text)    -- documents within Chapters
```

### Label meanings (LabelID)

| ID | Meaning |
|---|---|
| 7 | Part |
| 2 | Chapter |
| 4 | Scene |
| 8 | Sequel |
| 1 | Idea |
| 5 | Notes |
| 6 | Character |
| 9 | Narrative |

### Status meanings (StatusID)

| ID | Meaning | Maturity |
|---|---|---|
| 1 | To Do | Outline only |
| 2 | First Draft | Rough |
| 26 | BLOCKED | Needs author decision |
| 28 | Second Draft | Drafted |
| 29 | Deferred for 2nd Draft | Deferred |
| 30 | Incorporated in 2nd Draft | Incorporated |
| 31 | Backstory | Reference material |
| 32 | Out of Place | Displaced |

## Reading content

### RTF to plain text

On macOS, convert RTF to plain text:

```
textutil -convert txt -stdout "path/to/content.rtf"
```

### Scrivener formatting markers

RTF files may contain inline markers. Strip these
from output:

- `<$ScrKeepWithNextSplittable>`
- `<$Scr_Ps::0>`
- `<$Scr_H::...>`
- Other `<$Scr_...>` patterns

### Synopsis and notes

- `synopsis.txt` — plain text, no conversion needed
- `notes.rtf` — use same `textutil` conversion

## Scope resolution

Given a scope modifier (`scene [title]`,
`chapter [title]`, `part [title]`, `manuscript`):

1. Parse the `.scrivx` to build the binder tree.
2. Find the DraftFolder (Type="DraftFolder").
3. Walk children to locate the target by title match.
4. For `scene`: return the single Text item's UUID.
5. For `chapter`: return the Folder and all child
   Text items' UUIDs.
6. For `part`: return the Part Folder and all
   descendant UUIDs.
7. For `manuscript`: return the entire DraftFolder
   tree.

Title matching is case-insensitive and supports
partial matches when unambiguous.

## Binder child enumeration (mandatory)

When enumerating children of a chapter or part folder
in the `.scrivx` file using grep:

- Always use **`-A 60` minimum context**. If a chapter
  contains many scenes or the result seems incomplete,
  use `-A 120`.
- **Declare the child count** before reading any scene
  content. Format: `[Chapter Title]: N scenes found —
  [UUID1, UUID2, ...]`
- **Never declare scope complete** without an explicit
  child count step. "Two files found" is not scope
  confirmation — verify against the binder XML.
- If the count is uncertain after `-A 60`, re-run
  with `-A 120` before proceeding.

## Content assembly

For a given scope, assemble content by reading each
item's `Files/Data/{UUID}/content.rtf` in binder
order.

For context (adjacent scenes), read the synopsis.txt
of surrounding items rather than full content, to
stay within context budget.

## Maturity detection

Read each scene's StatusID to determine maturity
level. When no StatusID is present, treat as
unclassified (equivalent to First Draft for
evaluation purposes).

## Boundary

What scrivener-nav IS: how to find and read content
in a Scrivener project.

What scrivener-nav is NOT: how to write to Scrivener
projects. Writing is a command-level concern, not a
talent-level one. The syndicate reads from Scrivener;
the author writes to it.
