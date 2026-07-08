---
name: contrarian-loop
description: Use when a user asks for high-value multi-round development, delegated agent work, launch-quality app polish, real-environment validation, or any implementation loop where an independent evaluator must be able to reject incomplete work.
---

# Contrarian Loop

Run complex work as one controlled loop: plan, build, evaluate, and repeat until the artifact is usable under real evidence.

Use this as the single long-running development loop. Do not stack it with another loop skill such as a generic agent harness or an app-polish driver; import the needed constraints into the loop envelope, sprint contract, and evaluator checklist here.

For background and calibration notes, read `references/long-running-harness-notes.md` when designing a new loop, tuning the evaluator, or deciding whether the heavy protocol is justified.

## Fit Check

Start with a lightweight plan plus direct verification unless all of these are true:

- The task is high-value, repeated, risky, or large enough to justify multiple passes.
- Success can be checked by tests, browser automation, simulator screenshots, API calls, database state, CLI output, logs, or a clear review rubric.
- The budget is bounded by max rounds, time, commands, files, cost, or user-visible scope.
- Failed evaluation can produce specific findings the next Generator can act on.

Do not use the loop for one-off scripts, early prototypes, tiny config edits, vague strategy work, or tasks with no observable pass/fail surface.

## Core Rule

Separate the roles even when one agent performs them sequentially. The loop is only real when an Evaluator can reject the Generator's work with evidence.

If the work changes behavior or fixes a bug, the Generator should write or identify a failing test before implementation when the repository has a realistic test surface. If no automated test is practical, the sprint contract must name the manual or real-environment check that replaces it.

## Roles

### Planner

- Convert the user goal into product scope, feature list, user stories, data/state notes, and sprint order.
- Write `docs/contrarian-loop/plan.md`.
- Create or update `docs/contrarian-loop/feature_list.json`.
- Define the loop envelope before implementation begins.
- Keep acceptance criteria ambitious but testable.
- Avoid fragile implementation details unless the user or repository makes them mandatory.
- Never delete or weaken acceptance criteria. Only mark an item passed with evidence.

### Generator

- Implement one sprint or one feature at a time.
- Before coding, negotiate a Sprint Contract with Evaluator and write it to `docs/contrarian-loop/contracts/<sprint>.md`.
- Do not change acceptance criteria, scoring rules, or evaluation thresholds.
- If baseline smoke tests fail at session start, fix the baseline before adding new scope.
- Preserve dirty user work. Do not reset, discard, push, submit, or publish unless the user explicitly assigned that authority.
- End each sprint with code in a mergeable state, progress updated, and verification commands recorded.

### Evaluator

- Verify the running artifact as a real user, not by reading the diff alone.
- Use the strongest real tools available: browser automation, simulator, CLI commands, API calls, database checks, screenshots, logs, or test suites.
- Exercise the public surface before inspecting internals.
- Score against hard thresholds. If any required dimension fails, the sprint fails.
- Write detailed critique with exact evidence and file or behavior references to `docs/contrarian-loop/evaluations/<sprint>-round-<n>.md`.
- Do not edit code during evaluation. Record findings only.

## Loop Envelope

Before the first sprint, write these decisions in `docs/contrarian-loop/plan.md` or `progress.md`:

- Objective and user-visible outcome.
- Explicit non-goals and out-of-scope areas.
- Max rounds, time budget, and stop condition.
- Rollback rule and protected files.
- Baseline commands and required final evidence.
- Target runtime or device: browser, simulator, app store tooling, API, database, CLI, or other concrete surface.
- External agent policy: allowed tools, target directory boundary, commit/push/reset permissions, and supervision cadence.

If the work may exceed one session or context window, create `progress.md`, `feature_list.json`, and a short handoff note before substantial implementation.

## Runtime Modes

### Multi-Agent Mode

Use this when separate agents or sessions are available.

- Assign Planner, Generator, and Evaluator to separate contexts.
- Give each role only the files, commands, and constraints it needs.
- Use files as the handoff boundary; do not rely on chat memory.
- Let a coordinator start each role, inspect artifacts, enforce iteration limits, and stop when acceptance criteria pass.
- Ensure Evaluator has real execution tools and cannot silently patch the implementation.

### Single-Agent Role Rotation

Use this when separate agents are unavailable.

- Serially switch roles in one conversation.
- Declare each switch, for example: "Now evaluating as Evaluator."
- Before switching, write the role's output to disk.
- When entering the next role, read from disk instead of relying on prior chat memory.
- During Evaluator phase, do not fix issues inline; write the evaluation report first.

### Hybrid Coordinator Mode

Use this when one primary agent delegates bounded work to external CLI agents such as Cursor CLI, Claude Code, or Copilot CLI.

- Coordinator owns planning, role prompts, iteration limits, and final verification.
- External agents perform one bounded role pass and write their output to agreed files.
- Coordinator treats external reports as evidence to verify, not truth to trust blindly.
- Supervise lightly. A healthy external-agent run can be quiet; inspect files, logs, process state, and cwd before interrupting.
- Use a long polling cadence for slow app work. Fifteen minutes is a reasonable default unless the user asks for tighter monitoring.

## Artifact Protocol

Use this default layout unless the repository already has an equivalent convention:

```text
docs/contrarian-loop/
  plan.md
  feature_list.json
  progress.md
  handoff.md
  contracts/
    <sprint>.md
  evaluations/
    <sprint>-round-<n>.md
  reports/
    <role>-<sprint>-round-<n>.md
```

`feature_list.json` should contain stable acceptance items with `description`, `steps`, `priority`, `status`, and `evidence` fields. Prefer JSON because agents are less likely to casually rewrite it than prose.

Example item:

```json
{
  "id": "F-001",
  "description": "User can create, edit, and persist a project from the primary workflow.",
  "steps": ["Open the app", "Create a project", "Edit fields", "Reload and confirm persistence"],
  "priority": "high",
  "status": "pending",
  "evidence": []
}
```

## Sprint Contract

Every sprint contract must include:

- Included behavior and explicit non-goals.
- Files or modules likely to change.
- Tests, builds, screenshots, UI flows, API calls, database checks, or CLI commands Evaluator will run.
- Hard fail criteria.
- Required evidence paths.
- External-agent constraints when delegation is used: target directory, no commit/push/reset/discard unless authorized, final report path, and exact completion marker if needed.

For app or UI polish, include target user, quality bar, accessibility or platform guidelines when relevant, supported languages, and required screenshots.

## Loop

1. Planner writes or refreshes plan, loop envelope, and feature list.
2. Generator and Evaluator agree on a Sprint Contract.
3. Generator implements the sprint and records commands run.
4. Evaluator performs real-environment validation.
5. On FAIL, Generator fixes only the reported issues and the loop repeats.
6. On PASS, move to the next sprint.
7. Stop when all required items pass, the iteration cap is reached, or further rounds are no longer cost-effective.

Set an iteration cap before starting. A practical default is five evaluation rounds per feature. If the same issue class repeats after several rounds, return to Planner and split or redesign the work.

## External Agent Passes

External agents are execution backends, not sources of truth.

Every external-agent prompt should require:

- Work in one absolute target directory.
- Modify only the target scope.
- Preserve user changes.
- Do not commit, push, reset, discard, submit, or publish unless the user explicitly assigned that authority.
- Implement, verify, fix, and verify again.
- Write a final report with exact command results and remaining risks.
- Record screenshots, logs, simulator/device names, URLs, or other evidence paths when relevant.
- Fix at least one self-discovered issue before stopping when the task is a polish round.

After an external pass, the coordinator must rerun the key verification commands independently and inspect the final diff. Do not accept the external report alone.

## App And UI Polish Rounds

For Flutter, SwiftUI, web, or similar product polish, use bounded rounds:

- Round 1: complete the primary workflow with docs, tests, and build proof.
- Round 2: polish interaction, inclusivity, visuals, copy, empty states, loading states, and error states.
- Round 3: run a self-review pass with fewer coordinator interventions.
- Later rounds: focused slices such as motion, Dynamic Type, localization, accessibility, performance, screenshots, or store-readiness surfaces.

Evidence rules:

- Cold-launch the app or page before capture.
- Capture fresh screenshots for key flows when visual quality matters.
- If a screenshot shows stale UI, previous navigation residue, or the wrong app, terminate the app/server and recapture.
- For mobile work, include simulator/device name and OS when relevant.
- For web work, include viewport sizes and console/network errors when relevant.

## Evaluation Dimensions

Use dimensions that match the product, but start with:

- Product depth: the feature is not a stub or thin shell.
- Functional usability: a user can complete the task without guessing.
- Design quality: layout, visual hierarchy, interaction choices, accessibility, and state handling are coherent.
- Originality: the result shows deliberate choices rather than generic defaults.
- Craft: spacing, contrast, copy, responsiveness, motion, and screenshots are polished.
- Code quality: implementation is maintainable and aligned with local patterns.
- Operational safety: no leaked secrets, destructive commands, lingering processes, untracked critical artifacts, or accidental release actions.

Evaluator must fail stubs, display-only controls, fake success messages, skipped verification, stale screenshots, and claims that are not backed by evidence.

## Loop Sizing

Use this default sizing unless the user specifies otherwise:

- Mini loop: one plan, one build, one judge pass for a small but risky change.
- Standard loop: up to three build-judge rounds for a feature or UI polish slice.
- Heavy loop: explicit user approval, durable artifacts, and long-running agent supervision for multi-hour product work.

If the accept rate is low after two failed rounds, pause and revise the contract or scope before spending another round.

## Session Start

At the start of each role pass:

1. Identify the repository and current branch.
2. Read repo instructions such as `AGENTS.md`, `CLAUDE.md`, `README.md`, docs maps, issue text, PRD/design docs, and existing test commands.
3. Read `docs/contrarian-loop/progress.md`, recent git history, and the active contract.
4. Read `feature_list.json` and choose the highest-priority pending item.
5. Run the repository's baseline setup, test, or smoke command.
6. Fix a broken baseline before starting new feature work.

## Completion Criteria

Only call the loop complete when:

- Required acceptance items are marked passed with evidence.
- Final Evaluator report passes every hard threshold.
- Verification commands, screenshots, logs, or other evidence paths are recorded.
- Known limitations and intentionally deferred criteria are explicit.
- The working tree is ready for the user's next integration step.

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Stacking multiple loop skills | Use `contrarian-loop` as the single loop and import needed constraints into the contract. |
| Starting a heavy loop for a tiny task | Use direct implementation and focused verification. |
| Letting Generator self-approve | Evaluator must be able to reject with evidence. |
| Delegating to an external agent without boundaries | Put target directory, permissions, report path, and verification commands in the prompt. |
| Trusting an external report | Rerun key checks independently and inspect the diff. |
| Accepting stale screenshots | Cold-launch and recapture on the correct app/page. |
| Continuing after repeated broad failures | Return to Planner and split or redesign the sprint. |
