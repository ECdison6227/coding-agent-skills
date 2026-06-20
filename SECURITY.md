# 安全策略

## 报告漏洞

如果你发现安全漏洞，**请不要开公开 Issue**。

请发邮件到 `2014184720@qq.com`，或在 GitHub 私下联系 [@ECdison6227](https://github.com/ECdison6227)。

报告时请包含：
- 漏洞描述和影响范围
- 复现步骤
- 你建议的修复方向（可选）

我会在收到报告后 72 小时内回复。

## 支持的版本

这套 Skill 是个人项目，只维护最新版本。

## 已知安全考量

- **Skill 脚本会执行 Bash 命令**：安装前请审查 `skills/*/scripts/*.sh` 的内容。
- `install.sh` 会复制文件到 `~/.agents/skills/`，不会执行任意代码，但会 `chmod +x` 脚本。
- `validate.sh` 会运行各脚本的 `--help` 做冒烟测试，不会修改系统。
- Skill 本身不收集、不上传任何数据。
