---
name: agent-triad-loop
description: Multi-agent iterative development harness using Planner, Generator, and Evaluator roles. Use when a user asks for long-running autonomous development, agent loops, multi-agent implementation, Planner/Generator/Evaluator workflows, sprint contracts, adversarial QA, real-environment validation, or polishing a product until it meets launch-quality acceptance criteria. Supports separate agents, coordinator-managed agents, CLI agents, and single-agent role rotation when subagents are unavailable.
---

# Agent Triad Loop

Run development as a closed loop: plan, build, evaluate, and repeat until the artifact is actually usable.

Use this only when the task is worth the overhead: repeated work, real validation available, and high enough value to justify multiple passes. For one-off scripts, small fixes, or early prototypes, use a lightweight plan plus direct verification instead.

For background and calibration notes, read `references/long-running-harness-notes.md` when designing a new loop, tuning the evaluator, or deciding whether the heavy protocol is justified.

## Roles

### Planner

- Convert the user goal into product scope, feature list, user stories, data model notes, and sprint order.
- Write `docs/agent-triad-loop/plan.md`.
- Create or update `docs/agent-triad-loop/feature_list.json`.
- Keep acceptance criteria ambitious but testable.
- Avoid fragile implementation details unless the user or repository makes them mandatory.
- Never delete or weaken acceptance criteria. Only mark an item passed with evidence.

### Generator

- Implement one sprint or one feature at a time.
- Before coding, negotiate a Sprint Contract with Evaluator and write it to `docs/agent-triad-loop/contracts/<sprint>.md`.
- Do not change acceptance criteria, scoring rules, or evaluation thresholds.
- If baseline smoke tests fail at session start, fix the baseline before adding new scope.
- End each sprint with code in a mergeable state, progress updated, and verification commands recorded.

### Evaluator

- Verify the running artifact as a real user, not by reading the diff alone.
- Use the strongest real tools available: browser automation, simulator, CLI commands, API calls, database checks, screenshots, logs, or test suites.
- Score against hard thresholds. If any required dimension fails, the sprint fails.
- Write detailed critique with exact evidence and file or behavior references to `docs/agent-triad-loop/evaluations/<sprint>-round-<n>.md`.
- Do not edit code during evaluation. Record findings only.

## Runtime Modes

### Multi-Agent Mode

Use this when separate agents or sessions are available.

- Assign Planner, Generator, and Evaluator to separate contexts.
- Give each role only the files and tools it needs.
- Use files as the handoff boundary; do not rely on chat memory.
- Let a coordinator start each role, inspect artifacts, enforce iteration limits, and stop when acceptance criteria pass.
- Ensure Evaluator has real execution tools and cannot silently patch the implementation.

### Single-Agent Role Rotation

Use this when the environment cannot spawn subagents, such as Cursor-only setups.

- Serially switch roles in one conversation.
- Declare each switch, for example: "Now evaluating as Evaluator."
- Before switching, write the role's output to disk.
- When entering the next role, read from disk instead of relying on prior chat memory.
- During Evaluator phase, do not fix issues inline; write the evaluation report first.

### Hybrid Coordinator Mode

Use this when one primary agent delegates bounded work to external CLI agents.

- Coordinator owns planning, role prompts, iteration limits, and final verification.
- External agents perform one bounded role pass and write their output to the agreed files.
- Coordinator treats external reports as evidence to verify, not truth to trust blindly.

## Artifact Protocol

Use this default layout unless the repository already has an equivalent convention:

```text
docs/agent-triad-loop/
  plan.md
  feature_list.json
  progress.md
  contracts/
    <sprint>.md
  evaluations/
    <sprint>-round-<n>.md
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

## Loop

1. Planner writes or refreshes plan and feature list.
2. Generator and Evaluator agree on a Sprint Contract.
3. Generator implements the sprint and records commands run.
4. Evaluator performs real-environment validation.
5. On FAIL, Generator fixes only the reported issues and the loop repeats.
6. On PASS, move to the next sprint.
7. Stop when all required items pass or the iteration limit is reached.

Set an iteration cap before starting. A practical default is five evaluation rounds per feature. If the same issue class repeats after several rounds, return to Planner and split or redesign the work.

## Evaluation Dimensions

Use dimensions that match the product, but start with:

- Product depth: the feature is not a stub or thin shell.
- Functional usability: a user can complete the task without guessing.
- Design quality: layout, visual hierarchy, and interaction choices are coherent.
- Originality: the result shows deliberate choices rather than generic defaults.
- Craft: spacing, contrast, copy, responsiveness, and state handling are polished.
- Code quality: implementation is maintainable and aligned with local patterns.

Any hard-threshold miss fails the round. Evaluator must stay skeptical: if something feels "probably okay", test it.

## Session Start

At the start of each role pass:

1. Identify the repository and current branch.
2. Read `docs/agent-triad-loop/progress.md`, recent git history, and the active contract.
3. Read `feature_list.json` and choose the highest-priority pending item.
4. Run the repository's baseline setup, test, or smoke command.
5. Fix a broken baseline before starting new feature work.

## Completion Criteria

Only call the loop complete when:

- Required acceptance items are marked passed with evidence.
- Final Evaluator report passes every hard threshold.
- Verification commands and known limitations are recorded.
- The working tree is ready for the user's next integration step.
