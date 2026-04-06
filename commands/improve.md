# improve

Reads session learnings and proposes modifications to forte and talent specs. Uses the coordination syndicate's spec-evolver. See `../../coordination/commands/improve.md` for the full spec-evolver protocol — this command wraps it for the novel-writing syndicate's domain.

## Fortes

| Step | Forte | Mode | Receives additionally |
|---|---|---|---|
| 1 | spec-evolver (coordination syndicate) | propose | `learnings.md`, all novel-writing forte and talent specs |

## Coordination pattern

Single-agent with author approval gate. The spec-evolver proposes changes. The author approves, modifies, or rejects each proposal individually. Approved changes are applied. Rejected proposals are recorded as "considered, not adopted" to prevent re-proposal.

## Context requirements

- `learnings.md` from the current project or caper
- All forte specs in `fortes/`
- All talent specs in `talents/`
- The spec-evolver forte spec (from coordination syndicate)

## Procedure

Per `../../coordination/commands/improve.md`:

1. **Fire spec-evolver.** Pass learnings and all forte and talent specs. The forte identifies patterns that indicate spec gaps — not one-offs — and drafts minimal changes with evidence traces.

2. **Present proposals individually.** For each: target spec, section, evidencing learning, current text, proposed change. The author decides per proposal.

3. **Apply approved changes.** Read the target spec, apply the exact change, confirm.

4. **Assess coherence.** Check whether other specs or command files still cohere with the changed specs. Present discrepancies for author decision.

5. **Record dispositions.** Update `learnings.md`: "promoted to spec", "considered, not adopted" (with reason), or "deferred".

## Output

- Modified forte/talent spec files (approved changes only)
- Updated `learnings.md` with dispositions

## Settlement condition

Every proposal has a disposition. Approved changes applied. Learnings updated.

## Boundary

Evolves specs from learnings. Does not operate on drafts or scene content. Runs between sessions or on explicit invocation — does not engage during drafting or evaluation.
