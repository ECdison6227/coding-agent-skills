#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage: scan-ui.sh [DIRECTORY]

Run read-only automated checks for common UI/UX issues:
- hard-coded text symbols (arrows, plus, close, etc.)
- vague button labels (OK / Cancel / 确定 / 取消)
- hard-coded Chinese strings outside translations
- unused or undefined CSS classes (best-effort)

Default directory: current directory
EOF
}

if [[ "${1:-}" == "--help" || "${1:-}" == "-h" ]]; then
  usage
  exit 0
fi

root="${1:-.}"

# Collect source files once for reuse
src_files=$(find "$root" \
  \( -name "*.jsx" -o -name "*.tsx" -o -name "*.js" -o -name "*.ts" -o -name "*.vue" \) \
  -type f 2>/dev/null || true)

echo "== UI automated scan: $root =="
echo

echo "-- 1. Text symbols in JSX/TSX/Vue/JS/TS --"
if [[ -n "$src_files" ]]; then
  # Match literal UTF-8 bytes — no -CSD needed
  echo "$src_files" | while IFS= read -r f; do
    [[ -f "$f" ]] || continue
    perl -ne 'print "$ARGV:$.: $_" if /[→←↑↓×✓~€¥]/' "$f" 2>/dev/null || true
  done
fi
echo

echo "-- 2. Vague button labels --"
if [[ -n "$src_files" ]]; then
  echo "$src_files" | while IFS= read -r f; do
    [[ -f "$f" ]] || continue
    perl -ne 'print "$ARGV:$.: $_" if /"(OK|Cancel|确定|取消|Submit|Click here)"/' "$f" 2>/dev/null || true
  done
fi
echo

echo "-- 3. Hard-coded Chinese outside translations --"
# Use -CSD so \x{4e00}-\x{9fff} matches Unicode code points in UTF-8 input
if [[ -n "$src_files" ]]; then
  echo "$src_files" | while IFS= read -r f; do
    [[ -f "$f" ]] || continue
    case "$f" in
      *translations*|*i18n*|*locales*) continue ;;
    esac
    perl -CSD -ne 'print "$ARGV:$.: $_" if /[\x{4e00}-\x{9fff}]/' "$f" 2>/dev/null || true
  done
fi
echo

echo "-- 4. Static 'Loading...' placeholders --"
if [[ -n "$src_files" ]]; then
  echo "$src_files" | while IFS= read -r f; do
    [[ -f "$f" ]] || continue
    perl -ne 'print "$ARGV:$.: $_" if /Loading\.\.\.|loading\.\.\./' "$f" 2>/dev/null || true
  done
fi
echo

echo "-- 5. Undefined CSS classes (best-effort) --"
jsx_classes="$(mktemp)"
css_classes="$(mktemp)"
trap 'rm -f "$jsx_classes" "$css_classes"' EXIT

if [[ -n "$src_files" ]]; then
  echo "$src_files" | while IFS= read -r f; do
    [[ -f "$f" ]] || continue
    perl -ne 'while (/className="([^"]*)"/g) { print "$1\n" }' "$f" 2>/dev/null
  done | tr ' ' '\n' | grep -v '^$' | sort -u > "$jsx_classes"
fi

css_files=$(find "$root" \( -name "*.css" -o -name "*.scss" \) -type f 2>/dev/null || true)
if [[ -n "$css_files" ]]; then
  echo "$css_files" | while IFS= read -r f; do
    [[ -f "$f" ]] || continue
    perl -ne 'while (/\.([a-z][-a-z0-9_]*)/g) { print "$1\n" }' "$f" 2>/dev/null
  done | sort -u > "$css_classes"
fi

if [[ -s "$jsx_classes" && -s "$css_classes" ]]; then
  comm -23 "$jsx_classes" "$css_classes" || true
fi
echo

echo "== Scan complete =="
