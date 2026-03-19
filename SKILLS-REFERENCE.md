# Skills Reference

Quick reference for all 19 syndicate commands and how
they relate to each other.

## Reconnaissance (what have I got?)

| Skill | What it does | Scope |
|---|---|---|
| `/map` | Maturity dashboard — status of every scene, no content read | manuscript |
| `/ledger` | Setup/payoff walk — logs narrative promises, ticks off payoffs, updates arc-tracker | chapter, part, manuscript |
| `/read` | Displays scene content (read-only) | scene, chapter, part |

These three never fire fortes, never evaluate, never
modify. Pure information gathering.

## Lifecycle (what's ready to work on?)

| Skill | What it does | Scope |
|---|---|---|
| `/harvest` | Surveys unfinished scenes by ripeness — what's composted enough to draft? | manuscript, part |
| `/survey` | Populates the persistent KB — fires continuity-keeper, character-warden, world-auditor in extraction mode | chapter, part |
| `/session` | Starts or ends a writing session — loads context at start, logs what happened at end | any |

`/session` is optional. All commands work without it.

## Structural understanding (what's going on here?)

| Skill | What it does | Fortes |
|---|---|---|
| `/explore` | Context and structure reconnaissance | scene-architect, continuity-keeper, world-auditor |

## Drafting (write it)

| Skill | What it does | Fortes |
|---|---|---|
| `/draft` | Writes scene prose, convergence loop (max 3 passes) | prose-scribe |
| `/revise` | Applies known corrections only — no rewriting | prose-scribe (correction mode) |

## Evaluation (does it work?)

| Skill | What it does | Fortes |
|---|---|---|
| `/evaluate` | Structure, character, dialogue, continuity, pacing | 5 fortes |
| `/mob` | Everything at once — full evaluative pass | all 8 evaluative |
| `/polish` | Voice protection + AI-tell detection | voice-guardian, cognition-sensor |
| `/audit` | Cross-scene consistency and world rules | continuity-keeper, world-auditor |

## End-to-end editorial

| Skill | What it does | Fortes |
|---|---|---|
| `/developmental` | Full dev edit: evaluate → propose → approval gate → redraft → verify voice → deliver with change log | 5 evaluative + prose-scribe + voice-guardian |
| `/subedit` | Full sub-edit: evaluate → problem list → approval gate → fix → checklist → deliver | voice-guardian, cognition-sensor, prose-scribe |

## Ideation (what could happen next?)

| Skill | What it does | Fortes |
|---|---|---|
| `/brainstorm` | Explores plot possibilities — reads artefacts, identifies gaps, proposes options with consequences | none (orchestrator-level) |

## Specialised

| Skill | What it does |
|---|---|
| `/mondegreen` | Chapter title candidates ("Suspicious Minds" mishearings) |
| `/improve` | Proposes spec changes based on session learnings |

---

## Typical workflow

```
/session start chapter "..."      declare scope and mode
    |
/map                              where am I?
/ledger part "..."                what's promised, what's paid off?
/harvest                          what's ripe?
    |
/read scene "..."                 load context
/explore chapter "..."            understand structure
/brainstorm chapter "..."         work through plot problems
    |
/draft scene "..."                write it
    |
/evaluate scene "..."             does it work?
/polish scene "..."               is the voice clean?
    |
/revise scene "..."               fix what was flagged
    |
/audit chapter "..."              consistency across scenes
/audit part "..."                 consistency across chapters
    |
/mob scene "..."                  final full pass (when in doubt)
    |
/session end                      log what happened
```

Arrows are typical, not mandatory. Any command can be
invoked at any time. Different scenes are at different
stages simultaneously.

## Artefacts

Persistent knowledge base files at `artefacts/`.
Updated by KB-equipped fortes during evaluation and
`/survey`, or by `/ledger` and `/session`.

| Artefact | Content |
|---|---|
| `characters.md` | Voice, decisions, relationships, arcs, knowledge states |
| `timeline.md` | Chronological events with scene citations |
| `continuity.md` | Object locations, established facts, character states |
| `world-rules.md` | World rules by domain |
| `ledger.md` | Setup/payoff tracking (tactical — individual promises) |
| `arc-tracker.md` | Narrative thread status, tension, dormancy (strategic — thread-level) |
| `session-log.md` | Running record of writing sessions |
