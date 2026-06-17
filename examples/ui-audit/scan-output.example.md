# UI Audit Scan Output

Command:

```bash
~/.agents/skills/ui-audit/scripts/scan-ui.sh ./src
```

## Results

```text
src/pages/Home.tsx:23        hardcoded Chinese: "加载中..."
src/pages/Home.tsx:41        hardcoded Chinese: "暂无数据"
src/components/Button.tsx:41 undefined CSS class: .btn-primary-active
src/App.tsx:58               text symbol: →
src/App.tsx:71               text symbol: ×
src/components/Modal.tsx:12  button text too long: "确定要删除吗"
src/components/Modal.tsx:28  button text vague: "确定"
src/components/Modal.tsx:29  button text vague: "取消"
```

## Fixes applied

1. Replaced `→` with `ChevronRight` icon from Lucide.
2. Replaced `×` with `X` icon.
3. Split vague modal buttons into "删除" / "放弃".
4. Moved Chinese strings to `src/locales/zh-CN.json` and wrapped with `t()`.
5. Removed undefined `.btn-primary-active` class; merged styles into `.btn-primary[data-active]`.
6. Shortened modal title to "删除任务？".

## Re-scan

```bash
~/.agents/skills/ui-audit/scripts/scan-ui.sh ./src
```

Output:

```text
No obvious UI issues found.
```
