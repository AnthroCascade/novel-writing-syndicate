# session

Starts or ends a writing session. At start, loads context for the declared scope. At end, logs what happened. Optional — all commands work without a session. Use this when you want a deliberate opening and closing to a block of work.

## Fortes

No fortes. Session management is orchestrator-level housekeeping.

## Coordination pattern

Single action. Either start or end, not both.

## Context requirements

**Start:**
- Scrivener project bundle
- `artefacts/session-log.md` (if exists — to check where you left off)
- KB artefact `_index.md` files (to know what context is available)

**End:**
- Knowledge of what was done during the session (from conversation context)
- `artefacts/session-log.md` (to append)

## Procedure

### Start

1. **Declare scope and mode.** The author specifies what they intend to work on: a scene, chapter, or part, and optionally what kind of work (drafting, evaluating, revising).

2. **Load context.** Parse the Scrivener binder. Read the target content. Read relevant KB artefact files. Read `artefacts/session-log.md` for prior session history. Present: what exists at this scope, current maturity, what the last session noted, any relevant KB context.

3. **Report readiness.** What's loaded, what's available, any flags from prior sessions.

### End

1. **Log what happened.** Append to `artefacts/session-log.md`: date, scope worked on, what was done (commands run, decisions made, draft status), any notes for the next session.

2. **Flag open threads.** Anything left unfinished, unapproved findings, decisions still needed.

## Output

**Start:** Context loaded, readiness report presented.
**End:** `artefacts/session-log.md` updated.

## Settlement condition

**Start:** Author has the context they need to begin work.
**End:** Session log entry written with enough detail that a future session can pick up where this one left off.

## Boundary

Housekeeping. Does not evaluate, draft, or make decisions. A session is a framing device for the author's work, not a prerequisite for it.
