#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_root"

fail() {
  echo "FAIL: $*" >&2
  exit 1
}

pass() {
  echo "PASS: $*"
}

required_files=(
  README.md
  README.en.md
  LICENSE
  install.sh
  scripts/validate.sh
  assets/banner.svg
  AGENTS.md
  CONTRIBUTING.md
  CHANGELOG.md
  SECURITY.md
  .gitignore
  .editorconfig
  .github/ISSUE_TEMPLATE/bug_report.md
  .github/ISSUE_TEMPLATE/feature_request.md
  examples/dev-workflow/handoff.example.md
  examples/polish-loop-v2/audit-report.example.md
  examples/ui-audit/scan-output.example.md
  skills/dev-workflow/SKILL.md
  skills/dev-workflow/automation.md
  skills/dev-workflow/templates.md
  skills/dev-workflow/scripts/init-handoff.sh
  skills/polish-loop-v2/SKILL.md
  skills/polish-loop-v2/scripts/duplicate-check.sh
  skills/ui-audit/SKILL.md
  skills/ui-audit/scripts/scan-ui.sh
)

for file in "${required_files[@]}"; do
  [[ -f "$file" ]] || fail "missing $file"
done
pass "required files exist"

for skill in skills/*/SKILL.md; do
  first_line="$(sed -n '1p' "$skill")"
  [[ "$first_line" == "---" ]] || fail "$skill missing YAML frontmatter opener"
  grep -q '^name:' "$skill" || fail "$skill missing name frontmatter"
  grep -q '^description:' "$skill" || fail "$skill missing description frontmatter"
done
pass "skill frontmatter is present"

bash -n install.sh || fail "bash syntax failed for install.sh"
bash -n scripts/validate.sh || fail "bash syntax failed for scripts/validate.sh"
for script in skills/*/scripts/*.sh; do
  bash -n "$script" || fail "bash syntax failed for $script"
done
pass "bash syntax is valid"

chmod +x install.sh scripts/validate.sh skills/*/scripts/*.sh

./install.sh --help >/dev/null
./install.sh --dry-run >/dev/null
./install.sh --target /tmp/agents-skills-test --dry-run >/dev/null
skills/dev-workflow/scripts/init-handoff.sh --help >/dev/null
skills/polish-loop-v2/scripts/duplicate-check.sh --help >/dev/null
skills/ui-audit/scripts/scan-ui.sh --help >/dev/null
pass "script smoke tests passed"

echo "Validation complete."
