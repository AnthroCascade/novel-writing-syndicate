# Novel Writing

## Fortes

- prose-scribe — drafts scene prose in the author's voice
- voice-guardian — protects voice in existing prose and dialogue
- scene-architect — scenes build, never catalogue
- continuity-keeper — the manuscript remembers what it said
- character-warden — characters are consistent, distinct, and growing
- dialogue-tuner — dialogue sounds like the speaker, not the author
- cognition-sensor — no AI tells in output
- pacing-reader — tension and release alternate, reader never trapped in one gear
- world-auditor — the world follows its own rules

## Misaligned game

All fortes suppress AI's default: produce smooth,
cinematic, emotionally-signposted fiction fast. The
author's voice is specific — satirical, grounded,
concrete, dry, Adams/Pratchett/Vonnegut DNA. The
default AI fiction voice is none of these things.

## Coordination

Not prescribed. Command chooses. Turn-taking is
simplest default.

## Governance (from developmental.md)

Every evaluative forte follows the developmental
editing protocol:

1. **Three silent reads** before any evaluation.
2. **Problem list** (max 15 per scene): exact quotes,
   one-sentence issue, minimal fix, "necessary not
   better" filter.
3. **Uncertainty flagging**: PRESERVE + flag + request
   direction. Never fix what might be voice.
4. **Escalation**: minor → flag with fix; moderate →
   flag with options; major → flag, NO FIX, request
   direction.
5. **Approval gates**: all evaluations are proposed,
   never presumed approved.
6. **Craft over copy**: every evaluative forte has an
   editorial stance section. The problem list must
   contain craft-level findings — structure, POV,
   character, dramatic logic, dialogue function,
   pacing. Surface corrections (typos, spacing,
   punctuation) are noted separately. A forte that
   returns only surface corrections has not done its
   job.

These governance rules apply to **every** evaluative
forte, not just voice-guardian.

## Failure modes

Seven named failure modes and their defences:

| Mode | Looks like | Primary defence | Recovery |
|---|---|---|---|
| **Premature resolution** | AI wraps up conflicts, explains mysteries too early | scene-architect (Change test) | "That resolves too early. Keep open until [X]." |
| **Information bleed** | Character acts on knowledge they don't have | character-warden (Knowledge test) + continuity-keeper | Check characters.md knowledge state for scene's timeline position |
| **Voice flattening** | Prose gets smoother, more generic across sessions | voice-guardian + cognition-sensor | Fire `/polish`; recalibrate against voice markers |
| **Helpful synopsis** | AI summarises rather than dramatises; tells not shows | scene-architect (Earn test) + dialogue-tuner | "That's synopsis, not scene. Show through action and dialogue." |
| **Arc amnesia** | Subplots vanish; threads set up earlier never return | ledger + arc-tracker | Fire `/ledger`; check arc-tracker for dormant threads |
| **Forte contradiction** | Two fortes give opposing advice (e.g. compress vs preserve) | Author decision | Present trade-off explicitly; author resolves |
| **Symptom fixing** | Fortes fix surface anomalies (typos, pronouns, spacing) instead of diagnosing the structural issue the anomaly signals. Multiple fortes converge on the same shallow fix, reinforcing each other's confidence. The real craft question goes unasked | Synthesis step symptom check + editorial stance sections in all evaluative fortes | "What structural question is this surface issue a symptom of?" Demote to B2 (surface corrections) and investigate the underlying craft issue as a B or C item |

## Idea lifecycle

The syndicate's workflow phases begin at Explore.
But scenes exist before the syndicate engages:

**Map** → **Compost** → **Harvest**

**Map** is structural reconnaissance. Parse the
Scrivener binder, report maturity levels per scene,
identify what exists and what is missing. The output
is a manuscript-wide maturity report grouped by
readiness. `/map`

**Compost** is the author's work and cannot be
automated. The author lives with the scenes. Some
nag while walking. Some surface while debugging.
Some clarify when re-reading a scene and thinking
"no, that is wrong, and I know why." This is where
the scene becomes the author's — where they discover
what the scene needs to do, distinct from what the
outline says it should do.

**Harvest** is recognition, not ranking. The author
surveys unfinished scenes to feel which ones have
ripened — which ideas they've internalised enough
that their voice can carry them. Readiness is not
sequence. A scene in Part 5 may be ready to write
before a scene in Part 2. A garden reports on
ripeness. `/harvest`

## Workflow phases

The syndicate declares its phases. The author
controls emphasis by choosing which phase and scope
to invoke. Phases are not sequential. Different
scenes are at different phases simultaneously.

| Phase | Fortes | Settles when |
|---|---|---|
| Explore | scene-architect, continuity-keeper, world-auditor | Scope understood, maturity mapped, context loaded |
| Draft | prose-scribe (+ convergence loop) | Author accepts scene |
| Evaluate | scene-architect, character-warden, dialogue-tuner, continuity-keeper, pacing-reader | Scene works as storytelling |
| Polish | voice-guardian, cognition-sensor | Voice clean, no AI tells |
| Audit | continuity-keeper, world-auditor | No internal contradictions at scope |
| Revise | prose-scribe (correction mode) | Known fixes applied |

### Phase mapping to edit levels

The three edit levels from the established editing
protocols map to syndicate commands:

- **Developmental** (structure/pacing) → `/developmental`
- **Line Edit** (voice polish/gentle compression) → `/subedit` (line edit)
- **Micro Edit** (typos/grammar/continuity only) → `/subedit` (micro edit)

These are **process commands** — end-to-end editorial
workflows that chain evaluation, approval, and
revision into a single invokable process. They
implement the full processes from `developmental.md`
and `subeditor.md` respectively.

The **phase commands** (`/evaluate`, `/polish`,
`/revise`) remain available as atomic operations when
the author wants evaluation without the full editorial
process. `/mob` fires all evaluative fortes regardless
of phase.

## Commands

### Workflow phase commands

Every command accepts a scope modifier:
`scene [title]`, `chapter [title]`, `part [title]`,
or `manuscript`. If no scope is provided, the command
asks the author to specify.

| Command | Phase | Fortes | Default pattern | Settles when |
|---|---|---|---|---|
| mob | (all) | all 8 evaluative | independent-evaluation | Synthesis delivered |
| draft | Draft | prose-scribe + convergence loop | convergence-loop | Author accepts |
| explore | Explore | scene-architect, continuity-keeper, world-auditor | independent-evaluation | Scope mapped |
| evaluate | Evaluate | scene-architect, character-warden, dialogue-tuner, continuity-keeper, pacing-reader | independent-evaluation | Scene works |
| polish | Polish | voice-guardian, cognition-sensor | independent-evaluation | Voice clean |
| audit | Audit | continuity-keeper, world-auditor | independent-evaluation | No contradictions |
| revise | Revise | prose-scribe (corrections) | single-forte | Corrections applied |

### Editorial process commands

End-to-end editorial workflows that chain evaluation,
approval, and revision into a single invokable
process. These implement the processes from
`developmental.md` and `subeditor.md`.

| Command       | Source protocol  | Evaluation fortes | Generation forte | Scope          |
|---------------|-----------------|-------------------|------------------|----------------|
| developmental | developmental.md | scene-architect, character-warden, dialogue-tuner, continuity-keeper, pacing-reader | prose-scribe (draft mode) → voice-guardian (verification) | scene, chapter |
| subedit       | subeditor.md    | voice-guardian, cognition-sensor | prose-scribe (revision mode) | scene, chapter |

### Lifecycle commands

These operate before the mob engages.

| Command | Lifecycle phase | What it does |
|---|---|---|
| map | Map | Parses Scrivener binder, reports maturity per scene, groups by readiness |
| harvest | Harvest | Surveys scenes by maturity, presents what each asks of the author |
| ledger | Ledger | Walks scenes in reading order, builds setup/payoff ledger at `artefacts/ledger.md` and updates arc-tracker |
| survey | Survey | Walks scenes extracting facts to the persistent KB. Fires continuity-keeper, character-warden, world-auditor in KB extraction mode |
| session | Session | Starts or ends a writing session. Loads context at start, logs what happened at end. Optional — all commands work without a session |

### Navigation commands

| Command | What it does |
|---|---|
| read | Reads and displays scene/chapter/part content from Scrivener |

### Specialised commands

| Command | What it does |
|---|---|
| mondegreen | Generates chapter title candidates as "Suspicious Minds" mondegreens |
| improve | Reads learnings, proposes modifications to forte and talent specs |
| brainstorm | Explores plot possibilities for undrafted or stuck scenes. Reads artefacts, identifies narrative gaps, proposes options with consequences |

## Maturity-aware behaviour

Commands adapt to scene maturity (from Scrivener
StatusID):

- **To Do (1)** — only scene-architect and
  continuity-keeper fire. Evaluate synopsis, not prose.
- **First Draft (2)** — lighter evaluation.
  Voice-guardian and cognition-sensor less relevant on
  rough prose. Structure and character fortes fire.
- **Second Draft (28)** — full evaluation, all fortes.
- **Blocked (26)** — `/explore` to understand context.
  Author decision required.
- **Out of Place (32)** — `/explore` to assess
  placement. Author decides.

## Resonance

Resonance describes when each forte naturally
engages:

- scene-architect: explore and evaluate phases, when
  structure questions arise
- continuity-keeper: always available, peaks during
  audit phase and when new scenes are drafted.
  Narrative-promises domain is informed by ledger
  data when available
- world-auditor: explore and audit phases, when
  technology or world rules are invoked
- character-warden: evaluate phase, when characters
  act or speak
- dialogue-tuner: evaluate phase, when dialogue
  scenes are assessed
- pacing-reader: evaluate phase, particularly at
  chapter and part scope
- prose-scribe: draft and revise phases
- voice-guardian: polish phase, but always available
- cognition-sensor: polish phase, but always available

## Knowledge base

See `talents/kb-extraction.md` for the full
KB protocol: artefact files, extraction stance, merge
rules, and context stratification.

KB-equipped fortes: continuity-keeper,
character-warden, world-auditor. They draw on the
kb-extraction talent and output `## KB Entries`
alongside their findings. The orchestrator persists
entries per the talent's merge protocol.

`/survey` is the dedicated KB assembly command —
fires only the three KB-equipped fortes in extraction
mode. Use it to systematically populate the KB before
running evaluation passes.

### Arc tracker

`artefacts/arc-tracker/` tracks narrative threads
at a strategic level (one file per thread, with
`_index.md` listing all threads) — thread status, tension state,
dormancy risk, and connections between threads. It
complements the ledger (tactical setup/payoff
tracking) with structural awareness of dramatic
progression. The `/ledger` command updates the arc
tracker when thread-level changes are detected. The
pacing-reader forte consults it during part-level
escalation analysis.

## Scrivener integration

The syndicate reads from Scrivener 3 project bundles
using hybrid integration:

1. Parse `.scrivx` for binder structure (hierarchy,
   UUIDs, titles, labels, statuses)
2. Read scene content from
   `Files/Data/{UUID}/content.rtf`
3. Read synopsis/notes from
   `Files/Data/{UUID}/synopsis.txt` and `notes.rtf`
4. Convert RTF via `textutil -convert txt -stdout`
5. Scope resolution matches titles in the parsed
   binder tree

See `talents/scrivener-nav.md` for full
navigation specification.
