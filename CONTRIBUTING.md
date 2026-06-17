# 贡献指南

欢迎给这套 Skill 提 Issue 和 PR。

## 提 Issue

- Bug：用 `.github/ISSUE_TEMPLATE/bug_report.md` 模板，附上触发词、Agent 环境、报错信息。
- 新 Skill 建议：用 `.github/ISSUE_TEMPLATE/feature_request.md` 模板，说明使用场景和预期效果。

## 提 PR

### 前置检查

```bash
# 1. Fork 后克隆
git clone https://github.com/<你的用户名>/coding-agent-skills.git
cd coding-agent-skills

# 2. 验证仓库完整性
./scripts/validate.sh

# 3. 创建分支
git checkout -b fix/your-bug-fix
```

### 新增 Skill 的要求

1. 在 `skills/` 下新建目录，目录名用小写加连字符（如 `my-new-skill`）。
2. 必须有 `SKILL.md`，包含 YAML frontmatter：
   ```yaml
   ---
   name: my-new-skill
   description: "一句话说明用途。Triggers: 触发词1, 触发词2"
   ---
   ```
3. 脚本放 `scripts/`，开头用 `#!/usr/bin/env bash` + `set -euo pipefail`。
4. 在 `install.sh` 的 `skills` 数组里加上新 Skill 名。
5. 在 `scripts/validate.sh` 的 `required_files` 里加上新文件。
6. 在 `README.md` 和 `README.en.md` 的触发词表格里加一行。
7. 在 `examples/` 下放至少一个示例文件。
8. 运行 `./scripts/validate.sh` 确认通过。

### 修改现有 Skill 的要求

- 只改必要的部分，不要顺手重构无关代码。
- 如果改了 SKILL.md 的触发词，同步更新 README 的触发词表格。
- 如果改了脚本接口，同步更新示例文件。

### PR 标题格式

```
<类型>: <简述>

类型：feat / fix / docs / refactor / chore
```

示例：`feat: add Vue support to ui-audit scanner`

### 代码规范

- Bash 脚本：`set -euo pipefail`，变量用 `${var}` 而非 `$var`。
- Markdown：中文用中文标点，代码块带语言标签。
- 不要在仓库里放真实个人信息、编译产物、node_modules。

## License

提交即表示你同意以 MIT License 授权你的贡献。
