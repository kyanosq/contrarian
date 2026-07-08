# Agent Council

Languages: [English](#english) | [简体中文](#简体中文)

Collection version: `0.1.0`

## English

`agent-council` is a personal collection of portable agent skills for multi-role thinking, implementation loops, and adversarial review. Each skill lives under `skills/<skill-name>` and can be symlinked into agent runtimes such as Codex and Cursor.

### Skills

| Skill | Version | Purpose |
| --- | --- | --- |
| `council-loop` | `0.1.0` | Planner / Generator / Evaluator loop for long-running development. |
| `council-brainstorm` | `0.1.0` | Multi-agent adversarial discussion for stronger decisions and ideas. |
| `council-review` | `0.1.0` | Targeted bug hunting with a consecutive-noise stop rule. |

### Install

Clone once, then install all skills as symlinks:

```bash
git clone https://github.com/kyanosq/agent-council.git ~/agent-council
~/agent-council/scripts/install.sh
```

The installer links every directory in `skills/` into:

- `~/.codex/skills/`
- `~/.cursor/skills/`

### Update

```bash
cd ~/agent-council
scripts/update.sh
```

`update.sh` runs `git pull --ff-only` and refreshes the symlinks.

### Use A Skill

Start a new agent session and explicitly name the skill:

```text
Use council-loop for this project.
Start as Planner, create docs/council-loop/plan.md, feature_list.json, and the first sprint contract.
Then run the Generator -> Evaluator loop until the agreed acceptance criteria pass or the iteration cap is reached.
```

```text
Use council-brainstorm to compare competing approaches before we choose a direction.
```

```text
Use council-review on this feature. Target correctness regressions and stop after 5 consecutive noise findings.
```

## 简体中文

`agent-council` 是一个个人 agent skills 集合，用于多角色思考、迭代实现和对抗性审查。每个 skill 都放在 `skills/<skill-name>` 下，可以软链接安装到 Codex、Cursor 等 agent runtime。

### Skills

| Skill | 版本 | 用途 |
| --- | --- | --- |
| `council-loop` | `0.1.0` | Planner / Generator / Evaluator 长时开发循环。 |
| `council-brainstorm` | `0.1.0` | 多智能体对抗性讨论，用来产出更强决策和想法。 |
| `council-review` | `0.1.0` | 目标驱动 bug 审查，带连续噪音发现停止规则。 |

### 安装

克隆一次仓库，然后把全部 skills 软链接安装：

```bash
git clone https://github.com/kyanosq/agent-council.git ~/agent-council
~/agent-council/scripts/install.sh
```

安装脚本会把 `skills/` 下的每个目录链接到：

- `~/.codex/skills/`
- `~/.cursor/skills/`

### 更新

```bash
cd ~/agent-council
scripts/update.sh
```

`update.sh` 会执行 `git pull --ff-only` 并刷新软链接。

### 启动 Skill

开启新的 agent 会话，并明确点名 skill：

```text
使用 council-loop 来开发这个项目。
先以 Planner 身份创建 docs/council-loop/plan.md、feature_list.json 和第一个 sprint contract。
然后按 Generator -> Evaluator 循环迭代，直到约定的验收标准通过，或达到迭代上限。
```

```text
使用 council-brainstorm 来比较几个候选方向，然后再决定实现路线。
```

```text
使用 council-review 审查这个功能。目标是正确性回归，连续 5 个噪音发现后停止。
```
