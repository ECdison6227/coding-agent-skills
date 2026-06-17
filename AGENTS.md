# AGENTS.md — 给 AI Agent 的项目指引

> 这个文件是给 AI coding agent（Trae / Claude Code / Codex 等）读的，告诉它这个仓库是什么、怎么用、怎么改。

## 仓库是什么

一套自用 AI 编程 Skill，适配支持 `.agents/skills` 目录的 Agent 环境。每个 Skill 是 `skills/` 下的一个子目录，核心是 `SKILL.md`（Agent 读取的指令）和 `scripts/`（可独立运行的脚本）。

## 仓库结构

```
skills/<skill-name>/
├── SKILL.md          # 必须，YAML frontmatter + 指令正文
├── scripts/          # 可选，Bash 脚本
├── templates/        # 可选，模板文件
└── *.md              # 可选，辅助文档
```

## 怎么用

1. 运行 `./install.sh` 安装到 `~/.agents/skills/`。
2. 在 Agent 环境中用触发词调用对应 Skill。
3. 不要直接修改 `~/.agents/skills/` 下的文件，改仓库源码后重新 `./install.sh`。

## 怎么加新 Skill

1. 在 `skills/` 下新建目录，目录名即 Skill 名。
2. 创建 `SKILL.md`，必须有 YAML frontmatter（`name` + `description`）。
3. 如有脚本放 `scripts/`，脚本必须 `chmod +x` 且 `bash -n` 通过。
4. 在 `install.sh` 的 `skills` 数组里加上新 Skill 名。
5. 在 `scripts/validate.sh` 的 `required_files` 数组里加上新文件。
6. 在 `README.md` 和 `README.en.md` 的表格里加上一行。
7. 运行 `./scripts/validate.sh` 确认通过。

## 编码规范

- **SKILL.md**：中文为主，触发词写在 description 里，用 `Triggers:` 标记。
- **脚本**：Bash 脚本用 `#!/usr/bin/env bash` + `set -euo pipefail` 开头。
- **文档**：Markdown 用中文标点，代码块带语言标签。
- **不要**：不要在仓库里放真实个人信息、不要放 node_modules、不要放编译产物。

## 验证

```bash
./scripts/validate.sh
```

验证内容：必需文件存在、frontmatter 完整、Bash 语法正确、脚本冒烟测试。
