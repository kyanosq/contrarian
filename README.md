# Contrarian / 杠精

Languages: [English](#english) | [简体中文](#简体中文)

Collection version: `0.2.0`

## English

`contrarian` is a personal collection of portable agent skills for structured disagreement, implementation loops, and adversarial review. Each skill lives under `skills/<skill-name>` and can be symlinked into agent runtimes such as Codex and Cursor.

### Design Ideas

`contrarian` is based on portable agent-workflow patterns rather than a specific model provider:

- Subagent context isolation: planning, implementation, critique, and synthesis can run in separate agent contexts so each role keeps its own assumptions and evidence.
- Adversarial collaboration networks: agents cross-examine proposals, generate alternatives, red-team assumptions, and force decisions to survive structured disagreement.
- Evidence-driven iteration: loops advance or stop based on acceptance criteria, real-environment validation, and consecutive-noise thresholds instead of confidence alone.
- Runtime portability: skills are plain Markdown instructions with optional agent metadata, so the same workflows can be installed into multiple agent runtimes.

### Skills

| Skill | Version | Purpose |
| --- | --- | --- |
| `contrarian-loop` | `0.2.0` | Unified Planner / Generator / Evaluator loop for long-running development, delegated agent work, and app polish. |
| `contrarian-brainstorm` | `0.1.0` | Multi-agent adversarial discussion for stronger decisions and ideas. |
| `contrarian-review` | `0.1.0` | Targeted bug hunting with a consecutive-noise stop rule. |

### Install

Clone once, then install all skills as symlinks:

```bash
git clone https://github.com/kyanosq/contrarian.git ~/contrarian
~/contrarian/scripts/install.sh
```

The installer links every directory in `skills/` into:

- `~/.codex/skills/`
- `~/.cursor/skills/`

### Update

```bash
cd ~/contrarian
scripts/update.sh
```

`update.sh` runs `git pull --ff-only` and refreshes the symlinks.

### Use A Skill

Start a new agent session and explicitly name the skill:

```text
Use contrarian-loop for this project.
Start as Planner, create docs/contrarian-loop/plan.md, feature_list.json, and the first sprint contract.
Then run the Generator -> Evaluator loop until the agreed acceptance criteria pass or the iteration cap is reached.
```

`contrarian-loop` is the single loop entrypoint. Put generic harness constraints, external-agent delegation rules, and app-polish screenshot evidence into its loop envelope and sprint contracts instead of stacking another loop skill beside it.

```text
Use contrarian-brainstorm to compare competing approaches before we choose a direction.
```

```text
Use contrarian-review on this feature. Target correctness regressions and stop after 5 consecutive noise findings.
```

## 简体中文

`contrarian` 是一个个人 agent skills 集合，中文名“杠精”。它用于结构化反对意见、迭代实现和对抗性审查。每个 skill 都放在 `skills/<skill-name>` 下，可以软链接安装到 Codex、Cursor 等 agent runtime。

### 设计思路

`contrarian` 参考的不是某个模型厂商，而是一组可迁移的 agent 工作模式：

- 子智能体上下文隔离：规划、实现、批判、综合可以放在不同 agent 上下文中运行，让每个角色保留自己的假设、证据和判断边界。
- 对抗式协作网络：不同角色会交叉质询方案、提出替代路径、红队审查假设，让决策经得起结构化反对意见。
- 证据驱动迭代：循环是否推进或停止，取决于验收标准、真实环境验证和连续噪音发现阈值，而不是单纯依赖“看起来可以”。
- 多 runtime 可移植：skill 使用普通 Markdown 指令和可选 agent 元数据，因此同一套流程可以安装到多个 agent runtime。

### Skills

| Skill | 版本 | 用途 |
| --- | --- | --- |
| `contrarian-loop` | `0.2.0` | 统一的 Planner / Generator / Evaluator 长时开发、外部 agent 委托和 App 打磨循环。 |
| `contrarian-brainstorm` | `0.1.0` | 多智能体对抗性讨论，用来产出更强决策和想法。 |
| `contrarian-review` | `0.1.0` | 目标驱动 bug 审查，带连续噪音发现停止规则。 |

### 安装

克隆一次仓库，然后把全部 skills 软链接安装：

```bash
git clone https://github.com/kyanosq/contrarian.git ~/contrarian
~/contrarian/scripts/install.sh
```

安装脚本会把 `skills/` 下的每个目录链接到：

- `~/.codex/skills/`
- `~/.cursor/skills/`

### 更新

```bash
cd ~/contrarian
scripts/update.sh
```

`update.sh` 会执行 `git pull --ff-only` 并刷新软链接。

### 启动 Skill

开启新的 agent 会话，并明确点名 skill：

```text
使用 contrarian-loop 来开发这个项目。
先以 Planner 身份创建 docs/contrarian-loop/plan.md、feature_list.json 和第一个 sprint contract。
然后按 Generator -> Evaluator 循环迭代，直到约定的验收标准通过，或达到迭代上限。
```

`contrarian-loop` 是唯一循环入口。通用 harness 约束、外部 agent 委托规则、App 打磨和截图证据都写入它的 loop envelope 与 sprint contract，不再叠加另一份 loop skill。

```text
使用 contrarian-brainstorm 来比较几个候选方向，然后再决定实现路线。
```

```text
使用 contrarian-review 审查这个功能。目标是正确性回归，连续 5 个噪音发现后停止。
```
