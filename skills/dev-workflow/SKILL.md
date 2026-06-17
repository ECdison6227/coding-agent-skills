---
name: dev-workflow
description: "通用软件开发全流程协调器。基于渐进性披露和上下文隔离原则，通过交接文档在子Agent间传递信息，避免上下文爆炸。Triggers: dev-workflow, 软件开发, 开发流程, build app, 构建软件, software development, dev process, 软件工程, 项目管理, project workflow"
---

# 通用软件开发全流程（渐进性披露版）

## 配套脚本

- `scripts/init-handoff.sh [--project NAME] [--phase PHASE]`：初始化 `.dev-workflow/` 目录和 `current-handoff.md` 交接文档。

## 核心原则

1. **先搭框架，能跑起来** — 先让主体流程跑通
2. **开发一个功能就测试一个** — 不要等全部做完再测
3. **先用最简单的 UI** — 黑白、无动画、无图标，后面再优化
4. **稳定为王** — 功能可用 > 美观
5. **渐进性披露** — 按需加载，避免上下文爆炸

## 上下文管理

**反模式（禁止）：**
- 主 Agent 读所有文件 / 子 Agent 继承所有上下文 / 把历史对话传给新线程

**正模式（必须）：**
- 主 Agent 只读交接文档（handoff document）
- 子 Agent 只读：交接文档 + 自己需要的文件
- 每个子 Agent 完成后写交接文档给下一个
- 交接文档只包含"下一步需要什么"

## 六阶段流程

```
Phase 0: 需求讨论（Brainstorming）→ 架构文档 + 交接文档
Phase 1: 快速构建（MVP）→ 可运行原型 + 交接文档
Phase 2: 功能验证（Baseline Check）→ 基线通过/不通过 + 交接文档
Phase 3: UI Loop（用户交互和视觉）→ 高完成度 UI + 交接文档
Phase 4: 功能 Loop（代码逻辑和性能）→ 稳定功能 + 交接文档
Phase 5: 回归验证（Final Test）→ 可交付软件
```

## 角色职责

### 主 Agent（协调者）

**永远不读代码，只读交接文档。**

工作流：
1. 读取 `.dev-workflow/current-handoff.md`
2. 判断当前阶段和任务
3. 启动子 Agent（传递：交接文档 + 需要的文件列表）
4. 等待子 Agent 完成，接收交接文档
5. 更新总交接文档，判断是否进入下一阶段

**禁止：** 打开代码文件、修改代码、审查代码逻辑、读历史对话

### 子 Agent（执行者）

**只读：交接文档 + 自己需要的文件。**

约束：
- 只能修改指定文件
- 完成后写交接文档（只包含"下一步需要什么"）
- 不读交接文档以外的文件、历史对话、其他子 Agent 的输出

### 子 Agent 文件数限制

| 类型 | 最大文件数 |
|------|-----------|
| 代码审查 | 10-15 |
| UI 优化 | 5-10 |
| Bug 修复 | 3-5 |
| 回归测试 | 不限（只运行测试） |

## 交接文档

### 存储位置

```
.dev-workflow/
├── current-handoff.md          # 当前交接文档（主 Agent 读这个）
├── archive/                    # 已完成 Phase 的归档
└── templates/                  # 模板文件
```

### 交接文档结构

```markdown
# Handoff Document

## 项目信息
- 项目名称 / 当前阶段 / 当前轮次 / 时间

## 已完成的工作（摘要）

## 当前状态
- 代码分支 / 已修改文件 / 已知问题

## 下一步任务
- 阶段 / 轮次 / 任务描述 / 需要修改的文件 / 验收标准

## 注意事项
```

详细模板见 [templates.md](templates.md)。

## 执行者 + 检测者模式

每个任务有执行者和检测者，确保质量。

```
主 Agent 启动执行者 → 执行者完成任务 → 写交接文档
    → 主 Agent 启动检测者 → 检测者验证 → 写检测报告
    → 通过 → 继续下一阶段
    → 不通过 → 让执行者修复
```

**检测者必须做运行时验证**（编译、启动、Playwright 走流程），不只做静态分析。

详细检测报告格式见 [templates.md](templates.md)。

## 自动化验证

每个 Phase 结束后自动运行测试，失败就停止。

验证内容：
- 编译成功（`npm run build`）
- 应用能启动
- Playwright 流程测试通过
- 功能正常

详细测试脚本和 Playwright 用例见 [automation.md](automation.md)。

## 主 Agent 换班

触发条件：上下文 >80% / 完成 3 个 Phase / 用户要求 / 进入新阶段

流程：旧主 Agent 写交接文档 → 新主 Agent 读交接文档继续协调

## 避免

```
□ 主 Agent 读所有文件（只读交接文档）
□ 子 Agent 继承所有上下文（只读交接文档 + 自己需要的文件）
□ 把历史对话传给新线程
□ 读 node_modules
□ 读其他子 Agent 的交接文档
```

## Phase 详细说明

### Phase 0: 需求讨论
- 执行者：主 Agent
- 输入：用户需求、参考产品、目标平台
- 输出：架构文档 + 交接文档

### Phase 1: 快速构建（MVP）
- 执行者：构建子 Agent
- 输入：Phase 0 交接文档
- 输出：可运行原型 + 交接文档

### Phase 2: 功能验证
- 执行者：polish-loop-v2（基线模式）
- 输入：Phase 1 交接文档
- 输出：基线通过/不通过 + 交接文档

### Phase 3: UI Loop
- 执行者：ui-audit
- Round 1: 文字极简 → Round 2: 动画补全 → Round 3: 图标系统 → Round 4: 视觉微调
- 每轮：读交接文档 + 修改文件 → 写交接文档

### Phase 4: 功能 Loop
- 执行者：polish-loop-v2（完整模式）
- 目标：更稳定、更快

### Phase 5: 回归验证
- 执行者：回归测试子 Agent
- 输出：测试报告

## 参考文件

- [templates.md](templates.md) — 交接文档、检测报告、检查清单模板
- [automation.md](automation.md) — 自动化测试脚本、运行时验证、回滚机制
