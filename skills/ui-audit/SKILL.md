---
name: ui-audit
description: "UI and user interaction audit: i18n completeness, CSS consistency, responsive layout, accessibility, error/loading/empty states, navigation flow. Catches the patterns that code reviewers miss. Triggers: ui-audit, UI审查, 界面审查, UI检查, interaction review, 交互审查, frontend audit, 前端审查, i18n check, 国际化检查"
---

# UI Audit — 界面与交互审查

**设计标准：极简主义 + 动画叙事 + 最少文字。**

**核心原则：能用视觉解决就不用文字，能用动画替代提示就用动画，必须用文字时用最少的字。**

## 配套脚本

- `scripts/scan-ui.sh [DIRECTORY]`：只读自动化扫描文字符号、模糊按钮文字、硬编码中文、静态 Loading、未定义 CSS 类等常见 UI 问题。

---

## 第 0 步：UI 基线检查（必须在任何审查之前执行）

### 导航基线

```
□ 用户能从任何页面回到主页/首页
□ 用户能从详情页返回列表页
□ 用户能从列表页进入创建/新建流程
□ 页面刷新后不丢失当前位置
```

### 状态处理基线

```
□ 每个数据加载有 loading 状态（skeleton/spinner）
□ 每个 API 调用有 error 状态（用户可见的错误提示）
□ 每个列表有空状态（没数据时的友好提示 + 行动引导）
□ 表单提交有 disabled 状态（防止重复提交）
```

### 认证基线

```
□ 登录页有"注册"入口
□ 注册页有"登录"入口
□ 登录后跳转到有意义的页面（不是白屏）
□ 退出登录后清除状态
□ Token 过期时自动跳转登录页
```

**基线不通过时，先修基线，不做其他 UI 审查。**

---

## 设计哲学

### 极简主义

```
□ 每个页面只有一个视觉焦点
□ 留白是设计的一部分
□ 颜色不超过 2 种主色 + 1 个强调色
□ 字体不超过 1 种
□ 无阴影、无渐变、无圆角超过 4px
□ 间距用 8px/16px/24px/32px 的倍数
```

### 动画叙事

```
□ 每个状态变化都有过渡动画（150-300ms）
□ 列表项进入有 stagger 动画（间隔 30-50ms）
□ 按钮点击有按压反馈（scale: 0.98）
□ 加载用 Skeleton，不是静态 placeholder
□ 错误用抖动动画或颜色变化，不是弹窗
□ 成功用短暂的高亮动画，不是 toast
```

### 最少文字

```
□ 按钮文字不超过 4 个字
□ 图标按钮无文字（用 tooltip 替代）
□ 无 "确定"、"取消" 等模糊文字（用 "保存"、"放弃" 替代）
□ 错误消息不超过 10 个字
□ 导航项不超过 2 个字 + 图标
```

### 不许出现文字符号

```
□ 无 → ← ↑ ↓（用箭头图标）
□ 无 ×（用关闭图标）
□ 无 + -（用添加/减号图标）
□ 无 > <（用 Chevron 图标）
□ 无 ✓ !（用 Check/Alert 图标）
□ 无 ~（用视觉分隔线）
□ 无 %（用进度条或圆环）
```

---

## 审查清单

### 1. 文字符号检查（最高优先级）

运行 `scripts/scan-ui.sh` 自动扫描，然后手动确认每个匹配是否需要替换为图标。

### 2. 图标系统检查

```
□ 常用操作图标齐全：save / trash / edit / arrow-left / x (close)
□ 导航图标齐全：search / plus / download / upload / external-link
□ 所有图标统一风格（线框或实心，二选一）
□ 图标大小统一（16px 操作、24px 导航、32px 空状态）
□ 图标来自同一图标库（如 Lucide / Heroicons / Phosphor），不混用
```

### 3. 动画检查

```
□ 页面切换有过渡动画（fade/slide）
□ 列表项进入有 stagger 动画
□ 按钮点击有按压反馈
□ 加载用 Skeleton 动画
□ 模态框/下拉菜单有展开动画
□ 长时间操作有进度动画
```

禁止：旋转 spinner 超过 2 秒、闪烁标签、无限循环动画、影响性能的复杂动画。

### 4. i18n 完整性

```
□ 所有用户可见文本使用 t() 函数
□ 无硬编码中文字符串（除 translations 文件外）
□ 错误消息使用 i18n key
□ aria-label 使用 i18n
```

### 5. CSS 一致性

```
□ JSX 中引用的 CSS 类都有定义
□ 无未使用的 CSS 类
□ z-index 层级一致（modal: 200, drawer: 100, backdrop: 99, toast: 300）
□ 颜色使用 CSS 变量或主题色，无硬编码 hex
□ 无 !important（除非有明确理由）
```

### 6. 死代码检查

```
□ 所有组件文件都被至少一个其他文件 import
□ 无同名文件（不同目录下的重复组件）
□ 无未使用的 import
```

### 7. 状态处理

```
□ 每个数据加载有 loading 状态
□ 每个 API 调用有 error 状态
□ 每个列表都有 empty 状态
□ 表单提交有 disabled 状态
□ 长时间操作有取消/中止支持
```

### 8. 导航流程

```
□ 所有路由都有对应的页面组件
□ 受保护路由有 auth guard
□ 404 有友好的 fallback 页面
□ 面包屑/返回按钮导航正确
□ 外部链接在新标签页打开
```

### 9. 响应式与无障碍

```
□ 移动端布局不溢出
□ 所有交互元素有 aria-label
□ 键盘可操作（Tab 导航、Escape 关闭、Enter 确认）
□ 模态框/面板有 focus trap
□ 颜色对比度符合 WCAG AA
```

---

## 工作流

### Phase 1: 自动化扫描

运行 `scripts/scan-ui.sh`，收集结果。重点关注：文字符号、过长按钮文字、缺少动画、硬编码中文、未定义 CSS 类。

### Phase 2: 手动验证

对照设计哲学和审查清单，逐个页面验证。用 Playwright 截图每个页面对照检查。

### Phase 3: 修复

按优先级修复：
1. 文字符号替换为图标
2. 文字简化
3. 动画补全
4. CSS 类补全
5. i18n 补全
6. 死代码删除
7. 状态处理
8. 导航流程

### Phase 4: 回归验证

修复后重新运行自动化扫描，确认无新增问题。

---

## 与 polish-loop-v2 的关系

- **polish-loop-v2**：通用代码审查（逻辑、安全、性能、运行时）
- **ui-audit**：专注前端 UI 和用户体验

**并行执行**，基线检查共用。ui-audit 的问题优先级高于 polish-loop-v2。
