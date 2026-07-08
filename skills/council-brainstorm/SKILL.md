---
name: council-brainstorm
description: Use when a user wants multi-agent brainstorming, adversarial discussion, devil's-advocate critique, competing proposals, red-team ideation, or decision exploration before implementation, planning, product strategy, architecture, or research work.
---

# Council Brainstorm

Use structured disagreement to improve ideas before committing to a direction. The goal is not debate theater; it is to expose hidden assumptions, generate stronger options, and converge on a decision with known tradeoffs.

## Roles

- **Moderator** defines the question, success criteria, constraints, and timebox.
- **Proposer** generates one or more concrete options.
- **Skeptic** attacks assumptions, edge cases, incentives, feasibility, and failure modes.
- **Synthesizer** merges the strongest parts into a recommended path.
- **Decider** records the final choice, open questions, and next validation step.

Use separate agents when available. In a single-agent environment, rotate roles explicitly and write each role's notes before switching.

## Workflow

1. State the decision question in one sentence.
2. Define success criteria and hard constraints.
3. Generate 2-4 distinct proposals independently.
4. Run adversarial critique against each proposal.
5. Let proposers revise once after critique.
6. Synthesize the best option, rejected alternatives, risks, and next validation step.

Write the result to `docs/council-brainstorm/<topic>.md` when the decision affects future work.

## Output Shape

Use this structure:

```markdown
# <Decision Topic>

## Decision Question

## Success Criteria

## Options

## Adversarial Critique

## Recommended Direction

## Rejected Alternatives

## Risks And Mitigations

## Next Validation Step
```

## Ground Rules

- Attack ideas, not people.
- Keep critiques specific and testable.
- Do not average weak proposals into a vague compromise.
- Do not let majority preference replace evidence.
- Surface assumptions explicitly.
- Stop when the next step is a concrete validation action, not another abstract discussion.

## Common Mistakes

| Mistake | Fix |
| --- | --- |
| Everyone sees the first idea before proposing | Generate options independently first. |
| Skeptic only says "risky" | Require specific failure modes and evidence. |
| Debate never converges | End with a decision, rejected alternatives, and next validation. |
| Single-agent role mixing | Write one role's notes before switching to the next. |
