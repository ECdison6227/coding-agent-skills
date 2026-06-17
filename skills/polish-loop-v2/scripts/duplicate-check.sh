#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: duplicate-check.sh [DIRECTORY]

Find duplicate file names and potentially dead code files.

Default directory: current directory
EOF
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi

root="${1:-.}"

echo "== Duplicate file name check: $root =="
find "$root" \( -name "*.jsx" -o -name "*.tsx" -o -name "*.js" -o -name "*.ts" -o -name "*.py" \) -type f \
  | xargs -I {} basename {} \
  | sort \
  | uniq -d \
  | while read -r name; do
      echo "Duplicate: $name"
      find "$root" -name "$name" -type f
      echo
    done

echo "== Duplicate check complete =="
