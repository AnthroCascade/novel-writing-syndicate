# explore

Reconnaissance command. Fires scene-architect, continuity-keeper, and world-auditor to understand what exists at the given scope — structure, established facts, world rules, and context. Use this before drafting to understand what a scene sits within, or when a scene is Blocked (26) or Out of Place (32) and needs its context mapped before the author can decide what to do.

## Fortes

| Step | Forte | Mode | Receives additionally |
|---|---|---|---|
| 1 (parallel) | scene-architect | explore | — |
| 1 (parallel) | continuity-keeper | explore | `artefacts/timeline.md`, relevant `artefacts/continuity/` files |
| 1 (parallel) | world-auditor | explore | Relevant `artefacts/world-rules/` files |

## Coordination pattern

Independent evaluation. All three fortes execute independently. Each reads the same content. KB-equipped fortes (continuity-keeper, world-auditor) also output `## KB Entries` sections.

## Context requirements

Before fortes fire:

- Scene/chapter/part content (from Scrivener via scrivener-nav)
- Synopsis and notes for target scenes
- Adjacent scene synopses
- Each forte's spec and all talents from its "Draws on" section
- Relevant KB artefact files (read `_index.md` first, then only entries relevant to current scope)

## Procedure

1. **Resolve scope.** Parse the Scrivener binder and locate the target. Explore works at scene, chapter, or part scope.

2. **Check maturity.** At To Do (1), fortes evaluate synopsis rather than prose. At Blocked (26) or Out of Place (32), the explore is specifically to understand why the scene is stuck and what context would help the author decide.

3. **Read content.** Convert RTF to text. Read synopsis and notes. Read adjacent scene synopses for context.

4. **Load KB context.** Read relevant atomic KB files for continuity-keeper and world-auditor.

5. **Execute all three fortes independently.** Scene-architect maps the structure (change, dependency, skip test). Continuity-keeper checks what the scene establishes, depends on, or contradicts. World-auditor catalogues what world rules are invoked and whether they are consistent.

6. **Collect outputs.** Write to `artefacts/evaluations/forte-[name].md`.

7. **Persist KB entries.** Merge per kb-extraction protocol.

8. **Present to author.** What was found — the structural map, continuity context, world rules in play. If Blocked or Out of Place, present what the fortes found that might inform the author's decision.

## Output

- `artefacts/evaluations/forte-scene-architect.md`
- `artefacts/evaluations/forte-continuity-keeper.md`
- `artefacts/evaluations/forte-world-auditor.md`
- KB artefact updates (if KB entries produced)

## Settlement condition

Scope understood, maturity mapped, context loaded. The author has what they need to decide what to do next.

## Boundary

Reconnaissance, not evaluation or drafting. Explore maps what exists and identifies context — it does not assess quality, propose restructuring, or generate prose. It tells the author what they're working with.
