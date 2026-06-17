#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: init-handoff.sh [--project NAME] [--phase PHASE]

Initialize the .dev-workflow directory and current-handoff.md.

Options:
  --project NAME   Project name. Default: current directory name.
  --phase PHASE    Current phase (0-5). Default: 0.
  --help, -h       Show this help.
EOF
}

project=""
phase="0"

while [[ $# -gt 0 ]]; do
  case "$1" in
    --project)
      [[ $# -ge 2 ]] || { echo "--project requires a value" >&2; exit 2; }
      project="$2"
      shift 2
      ;;
    --phase)
      [[ $# -ge 2 ]] || { echo "--phase requires a value" >&2; exit 2; }
      phase="$2"
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

[[ -n "$project" ]] || project="$(basename "$(pwd)")"

mkdir -p .dev-workflow/archive .dev-workflow/templates

cat > .dev-workflow/current-handoff.md <<EOF
# Handoff Document

## 项目信息
- 项目名称: ${project}
- 当前阶段: ${phase}
- 时间: $(date -u +%Y-%m-%dT%H:%M:%SZ)

## 已完成的工作（摘要）

## 当前状态
- 代码分支: $(git branch --show-current 2>/dev/null || echo "非 git 仓库")
- 已修改文件:
- 已知问题:

## 下一步任务
- 阶段:
- 轮次:
- 任务描述:
- 需要修改的文件:
- 验收标准:

## 注意事项
EOF

echo "Initialized .dev-workflow/current-handoff.md for project: ${project}"
