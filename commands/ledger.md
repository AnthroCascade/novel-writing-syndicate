# ledger

Walks scenes in reading order, builds or updates the setup/payoff ledger, and updates the arc tracker when thread-level changes are detected. The ledger tracks individual narrative promises (tactical); the arc tracker tracks narrative threads at a strategic level. Use this to map what the manuscript promises and whether it delivers.

## Fortes

No fortes. The orchestrator reads scenes directly and maintains the ledger and arc tracker.

## Coordination pattern

Sequential walk. Scenes are read in binder order. Each scene is checked for setups planted and payoffs delivered. Thread-level observations update the arc tracker.

## Context requirements

- Scrivener project bundle
- Scene content within scope (from Scrivener via scrivener-nav)
- `artefacts/ledger.md` (existing, if any — for incremental updates)
- `artefacts/arc-tracker/_index.md` and relevant thread files (existing, if any)

## Procedure

1. **Resolve scope.** Ledger works at chapter, part, or manuscript scope. Parse the Scrivener binder.

2. **Read existing artefacts.** If `artefacts/ledger.md` exists, read it. If `artefacts/arc-tracker/_index.md` exists, read it and relevant thread files.

3. **Walk scenes in reading order.** For each scene within scope:
   - Read the scene content (convert RTF to text)
   - Identify **setups**: anything that creates a reader expectation — planted objects, raised questions, character traits implying transformation, comic setups demanding callback
   - Identify **payoffs**: resolutions, partial advancements, complications, or deliberate subversions of existing setups
   - A setup can pay off multiple times. Each payoff is noted; the setup remains open until its primary obligation is met
   - Not every scene element is a promise. Self-justifying moments (comedy, atmosphere, character texture) don't go on the ledger unless they also create forward expectation

4. **Update the ledger.** Write to `artefacts/ledger.md`. Each entry: the promise, the scene that planted it, status (open/partially resolved/resolved/subverted), payoff scene(s) if any.

5. **Update the arc tracker.** When the walk reveals thread-level changes — a thread escalating, a thread going dormant, a new thread emerging — update the relevant files in `artefacts/arc-tracker/`. Each thread file tracks: status, tension state, dormancy risk, connections to other threads. Update `_index.md` if new threads are added.

6. **Flag gaps.** Setups planted in this scope that remain unresolved beyond it without apparent intention. Threads that have gone dormant across multiple chapters.

7. **Report.** Summary of ledger changes: new setups, payoffs logged, gaps identified. Arc tracker changes: thread status updates, dormancy warnings.

## Output

- `artefacts/ledger.md` (created or updated)
- `artefacts/arc-tracker/` files (updated if thread-level changes detected)

## Settlement condition

Ledger reflects the current state of narrative promises within scope. Arc tracker updated for any thread-level changes.

## Boundary

Tracks promises, not quality. The ledger records what the manuscript establishes and whether it delivers — it does not evaluate whether the promises are good or the payoffs are satisfying. That is `/evaluate`. Does not modify scene content.
