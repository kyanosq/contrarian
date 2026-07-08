# Agent Triad Loop

`agent-triad-loop` is a portable agent skill for running a long-lived development loop with three explicit roles:

- **Planner** turns a compact user goal into scope, artifacts, and acceptance criteria.
- **Generator** implements one bounded sprint at a time without changing the agreed criteria.
- **Evaluator** verifies the running product like a real user, records evidence, and either fails the sprint with actionable critique or marks criteria as passed.

The protocol is designed to work across multiple agent runtimes. It supports separate Planner / Generator / Evaluator agents, a coordinator-driven multi-agent setup, or a single agent that rotates roles when subagents are unavailable.

## What It Contains

- `skill/agent-triad-loop/SKILL.md` - the installable skill instructions.
- `skill/agent-triad-loop/references/anthropic-harness-notes.md` - background notes summarizing Anthropic-style long-running harness patterns and tradeoffs.

## Compatibility

The skill uses file-based handoff instead of chat-memory handoff, so it can run in:

- Codex or other systems with real subagents.
- Cursor or other single-agent environments through role rotation.
- CLI agent workflows where each role is a separate process.
- Hybrid flows where one coordinator assigns work to external agents and verifies the resulting artifacts.

## Suggested Repository Installation

Copy or symlink `skill/agent-triad-loop` into your agent's skill directory, for example:

```bash
cp -R skill/agent-triad-loop ~/.codex/skills/
cp -R skill/agent-triad-loop ~/.cursor/skills/
```

## Core Artifact Contract

Use ordinary project files as the shared interface between agents:

- `docs/agent-triad-loop/plan.md`
- `docs/agent-triad-loop/feature_list.json`
- `docs/agent-triad-loop/contracts/<sprint>.md`
- `docs/agent-triad-loop/evaluations/<sprint>-round-<n>.md`
- `docs/agent-triad-loop/progress.md`

Any runtime can implement the loop as long as roles honor those files and do not weaken acceptance criteria without evidence.
