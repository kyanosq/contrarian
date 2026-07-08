# Long-Running Harness Notes

These notes summarize the ideas behind the triad loop: long-running agent handoff, feature lists, real-environment validation, and adversarial evaluation.

## Long-Running Agent Failure Modes

Agents often work across multiple sessions. Each new session may have little or no reliable memory of previous work. Without a harness, two failures are common:

- Trying to build the whole application in one pass, exhausting context, and leaving a half-implemented state.
- Declaring victory too early after seeing partial progress.

The countermeasure is a durable handoff protocol:

- Initialize the project with runnable setup, progress files, git history, and a feature list.
- Store acceptance criteria in a structured file such as `feature_list.json`.
- Require each role pass to read progress, run baseline smoke checks, pick one bounded item, and update files before exiting.

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

## Cost And Scope Control

Multi-agent loops are expensive because each role rereads context, artifacts, and failure history. Judge the loop by cost per accepted change, not by total iterations.

Use the heavy loop only when the task is:

- repeated
- automatically or concretely verifiable
- valuable enough to justify multiple passes

For early prototypes, one-off scripts, or small fixes, use direct implementation with focused verification.

## Evolving The Harness

Every harness component encodes an assumption about what the model cannot reliably do alone. Recheck those assumptions as model quality changes. Remove one component at a time and observe impact. The Evaluator is overhead for easy tasks, but valuable near the edge of model reliability and in the last mile of product quality.
