---
name: adversarial-bug-review
description: Use when a user wants adversarial bug hunting, red-team code review, target-driven QA, suspicious edge-case review, or an audit loop that continues until recent findings are false positives, duplicates, or immaterial issues.
---

# Adversarial Bug Review

Run bug review as a target-driven adversarial loop. The reviewer looks for real defects, verifies evidence, and stops only when the review stops producing meaningful findings.

## Inputs

Before reviewing, define:

- **Target**: files, feature, PR, release, workflow, or behavior under audit.
- **Goal**: security, correctness, data loss, UX breakage, performance, regression risk, or general quality.
- **Stop rule**: stop after `N` consecutive noise findings. Default `N = 5`.
- **Out of scope**: files, concerns, or refactors not relevant to this review.

Noise means a false positive, duplicate, already-known issue, or issue with no meaningful user/developer impact.

## Severity Scale

| Label | Meaning |
| --- | --- |
| S0 | Critical: data loss, security break, crash, unusable primary path. |
| S1 | High: common workflow broken, serious regression, wrong persisted state. |
| S2 | Medium: real bug with workaround or limited scope. |
| S3 | Low: polish issue or minor edge case. |
| Noise | False positive, duplicate, irrelevant, or immaterial issue. |

Only S0-S2 reset the noise counter by default. Count S3 as noise unless the user says low-severity issues matter for this target.

## Review Loop

1. Restate the target, goal, stop rule, and out-of-scope areas.
2. Form one bug hypothesis at a time.
3. Inspect code, run commands, or exercise the product to verify the hypothesis.
4. Record each finding with evidence and severity.
5. If the finding is S0-S2, reset the consecutive-noise counter to `0`.
6. If the finding is Noise or non-material S3, increment the counter.
7. Continue until the counter reaches `N`, the review budget is exhausted, or the user stops the review.

If fixing bugs during the same session, write or identify a failing test before editing implementation code.

## Finding Contract

A real finding must include:

- title
- severity
- affected file or behavior
- reproduction path or reasoning chain
- expected vs actual behavior
- concrete fix direction
- confidence level

If any of these are missing, classify it as a hypothesis, not a bug.

## Output Shape

```markdown
# Adversarial Bug Review: <target>

## Scope

## Stop Rule
N = <number>; stopped after <count> consecutive noise findings.

## Findings

### S1: <title>
- Evidence:
- Impact:
- Fix direction:
- Confidence:

## Noise Log

## Residual Risk

## Recommendation
```

Write durable reviews to `docs/adversarial-bug-review/<target>.md` when they affect release or merge decisions.

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Reporting guesses as bugs | Verify evidence or mark as hypothesis. |
| Chasing endless low-value issues | Use the consecutive-noise stop rule. |
| Counting duplicates as progress | Count duplicates as noise. |
| Ignoring target scope | Restate scope before every review pass. |
| Fixing during review | Record findings first; fix only after the review decision. |
