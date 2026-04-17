# developmental

Full developmental edit pipeline: evaluate, propose changes, author approval gate, redraft, verify voice, deliver with change log. This is an end-to-end editorial workflow — it chains evaluation, approval, and revision into a single process. Use this when a scene or chapter needs structural editing (pacing, character, dialogue, scene function) and you want the full loop rather than separate `/evaluate` then `/revise` commands.

## Fortes

| Step | Forte | Mode | Receives additionally |
|---|---|---|---|
| 1 (parallel) | scene-architect | evaluate | — |
| 1 (parallel) | character-warden | evaluate | Relevant `artefacts/characters/` files |
| 1 (parallel) | dialogue-tuner | evaluate | — |
| 1 (parallel) | continuity-keeper | evaluate | `artefacts/timeline.md`, relevant `artefacts/continuity/` files |
| 1 (parallel) | pacing-reader | evaluate | `artefacts/arc-tracker/` if available |
| 2 | prose-scribe | draft (redraft) | Approved proposals, inventory of what's working |
| 3 | voice-guardian | verify | Redrafted prose |

## Coordination pattern

Three-phase pipeline with approval gate.

**Phase 1 — Evaluate.** Five evaluative fortes execute independently. Each produces a problem list (max 15 per scene) following the developmental editing governance: three silent reads, exact quotes, one-sentence issues, minimal fixes, "necessary not better" filter, craft-level findings mandatory.

**Phase 2 — Propose and approve.** The orchestrator compiles findings into a proposal list. Each proposal: exact quote, issue, proposed fix, severity. The author approves, modifies, or rejects each proposal individually. This is the approval gate — nothing proceeds without explicit author decision.

**Phase 3 — Redraft and verify.** Prose-scribe redrafts with approved changes. Voice-guardian verifies the redraft hasn't introduced voice violations. Change log delivered.

## Context requirements

Before evaluation fortes fire:

- Scene/chapter content (from Scrivener via scrivener-nav)
- Synopsis, notes, adjacent scene synopses
- Each forte's spec and all talents from its "Draws on" section
- Relevant KB artefact files per context stratification
- Prose-scribe and voice-guardian specs and talents (for phases 2–3)

## Procedure

1. **Resolve scope.** Scene or chapter. Parse the Scrivener binder.

2. **Check maturity.** Developmental editing at To Do (1) operates on synopsis. At First Draft (2) or Second Draft (28), operates on prose.

3. **Inventory what's working.** Before evaluation, the orchestrator reads the prose and produces a paragraph-level inventory of what's working. Be specific — name what makes each passage good. This protects against faustian regression in the redraft.

4. **Execute evaluative fortes independently (Phase 1).** Each follows the developmental editing governance: three silent reads, problem list, uncertainty flagging, escalation protocol, craft over copy.

5. **Compile proposals (Phase 2).** Collect findings. Remove duplicates. Check for symptom fixing — are multiple fortes converging on the same shallow fix? If so, ask the structural question the surface issue signals. Present proposals individually to the author for approval.

6. **Author approval gate.** Each proposal: approve, modify, or reject. No proceeding without explicit decisions.

7. **Fire prose-scribe in redraft mode (Phase 3).** Pass: approved proposals, inventory of what's working, current prose. The drafter protects what's working while addressing approved changes.

8. **Fire voice-guardian in verify mode.** Check the redraft against voice markers. Flag any voice violations introduced by the redraft.

9. **Deliver.** Redrafted prose, change log (every change accounted), voice verification results.

## Output

- Evaluation files from all five fortes
- Proposal list with author decisions
- Redrafted prose with change log
- Voice verification results

## Settlement condition

All proposals have dispositions. Approved changes are applied. Voice is verified clean. Change log is complete.

## Boundary

Developmental editing — structure, pacing, character, dialogue, continuity. For line editing (voice polish, gentle compression) or micro editing (typos, grammar, continuity only), use `/subedit`. Does not operate at part or manuscript scope — use `/audit` for cross-chapter consistency.
