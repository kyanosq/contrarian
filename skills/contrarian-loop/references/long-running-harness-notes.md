# Long-Running Harness Notes

These notes summarize the ideas behind the contrarian loop: long-running agent handoff, feature lists, real-environment validation, adversarial evaluation, bounded external-agent delegation, and app-polish evidence.

## Long-Running Agent Failure Modes

Agents often work across multiple sessions. Each new session may have little or no reliable memory of previous work. Without a harness, two failures are common:

- Trying to build the whole application in one pass, exhausting context, and leaving a half-implemented state.
- Declaring victory too early after seeing partial progress.

The countermeasure is a durable handoff protocol:

- Initialize the project with runnable setup, progress files, git history, and a feature list.
- Store acceptance criteria in a structured file such as `feature_list.json`.
- Require each role pass to read progress, run baseline smoke checks, pick one bounded item, and update files before exiting.

## Single Loop Principle

Use `contrarian-loop` as the single long-running development loop. Do not maintain separate generic harness and app-polish loop skills beside it. When a task needs those behaviors, express them inside the loop envelope and sprint contract:

- whether the task justifies a loop at all
- what budget and stop condition apply
- which external agents may run
- what permissions they have
- which app, browser, simulator, API, database, or CLI surfaces prove the result

This keeps future agents from stacking overlapping protocols and losing the handoff boundary.

## Feature List Pattern

Use a structured feature list with all items initially pending. Each item should include:

- stable id
- category or priority
- description
- executable steps
- status
- evidence

Agents must not remove, weaken, or silently rewrite acceptance items. They may only mark items passed when evidence is attached.

## Why Separate Generator And Evaluator

Self-evaluation is unreliable. The agent that built the work is biased toward seeing it as complete. A separate Evaluator can be tuned to be skeptical, gather evidence, and reject shallow work.

The Evaluator should not judge by reading the diff alone. It should operate the product through realistic tools:

- browser automation for web apps
- simulator and screenshot workflows for mobile or desktop apps
- real CLI commands for services and command-line tools
- API and database checks when persistence or backend behavior matters

## Sprint Contract

Before implementation, Generator and Evaluator should agree on a Sprint Contract:

- what the sprint includes
- what is out of scope
- exact pass/fail criteria
- commands or interactions Evaluator will run
- evidence required to mark the sprint passed

The contract bridges a broad product spec and testable implementation work.

Add external-agent constraints to the contract when delegation is used:

- absolute target directory
- files or directories in scope
- commands to run
- report path and completion marker
- no commit, push, reset, discard, submit, or publish unless the user explicitly assigned that authority
- screenshots, logs, simulator names, URLs, or other evidence expected from the pass

Coordinator verification still matters. External reports are evidence to check, not truth to trust.

## Evaluation Calibration

Evaluator prompts usually need tuning. Common weak evaluator behavior includes:

- finding real bugs but deciding they are not important
- testing only the happy path
- accepting visual or UX work that is generic or unfinished
- missing stubs because a surface-level command succeeds

Use hard thresholds and examples to calibrate the evaluator. If any required dimension fails, the round fails.

Useful dimensions:

- product depth
- functionality
- design quality
- originality
- craft
- code quality
- operational safety

## App And UI Polish Evidence

Visual polish is easy to overclaim. Require fresh evidence:

- cold-launch the app or page before screenshot capture
- include simulator/device name or browser viewport when relevant
- check console, logs, or crash output where possible
- recapture when the image shows stale navigation state, a previous app, wrong route, or old server output
- prefer user-like workflows over isolated component inspection

For multi-round app polish, a useful progression is:

1. primary workflow with docs, tests, and build proof
2. interaction, accessibility, visuals, copy, and state polish
3. self-review pass with fewer coordinator interventions
4. focused slices such as motion, Dynamic Type, localization, performance, screenshots, or store-readiness surfaces

## Cost And Scope Control

Multi-agent loops are expensive because each role rereads context, artifacts, and failure history. Judge the loop by cost per accepted change, not by total iterations.

Use the heavy loop only when the task is:

- repeated
- automatically or concretely verifiable
- valuable enough to justify multiple passes

For early prototypes, one-off scripts, or small fixes, use direct implementation with focused verification.

## Evolving The Harness

Every harness component encodes an assumption about what the model cannot reliably do alone. Recheck those assumptions as model quality changes. Remove one component at a time and observe impact. The Evaluator is overhead for easy tasks, but valuable near the edge of model reliability and in the last mile of product quality.
