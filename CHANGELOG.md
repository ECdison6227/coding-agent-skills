# CHANGELOG

本仓库的版本变更记录。格式参考 [Keep a Changelog](https://keepachangelog.com/zh-CN/1.1.0/)。

## [Unreleased]

### Added
- 新增 `.gitignore`、`.editorconfig`、`AGENTS.md`、`CONTRIBUTING.md`、`SECURITY.md`
- 新增 `.github/ISSUE_TEMPLATE/` bug 和 feature 模板
- README 新增顶部导航、目录、推荐工作流图、标准 Prompt 章节

### Changed
- 仓库名从 `agents-skills` 改为 `coding-agent-skills`
- README 标题改为「EC 的编程 Skill」
- banner 从 AI 生成的占位图改为 SVG 流程图

### Removed
- 移除 `resume-builder` Skill（将单独开源）

## [0.2.0] - 2026-06-16

### Added
- `polish-loop-v2`：新增硬性 5 轮上限、回归守卫、变更聚焦、去重检查
- `ui-audit`：新增 `scan-ui.sh` 自动化扫描脚本
- `dev-workflow`：新增渐进性披露和上下文隔离机制
- `resume-builder`：基于 LaTeX 的中英文简历生成器
- `install.sh`：一键安装到 `~/.agents/skills/`
- `scripts/validate.sh`：仓库完整性验证

### Fixed
- `ui-audit` 扫描脚本在 macOS BSD grep 下报 `invalid character range`，改用 `perl`
- `polish-loop` 无限迭代问题，改为 `polish-loop-v2` 硬性 5 轮上限

## [0.1.0] - 2026-05-01

### Added
- 初始版本，包含 `polish-loop`（无轮次上限版）和基础 `dev-workflow`
