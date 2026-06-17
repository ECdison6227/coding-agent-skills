## 审查完成

**2 轮审查，累计修复 7 个问题。**

| 轮次 | 范围 | CRITICAL | HIGH | MEDIUM | LOW | 回归 |
|------|------|----------|------|--------|-----|------|
| 1    | 全量 | 0        | 2    | 3      | 2   | —    |
| 2    | 变更 | 0        | 0    | 1      | 1   | ✅   |

### 第 1 轮发现的问题

- **HIGH** `src/hooks/useTodos.ts:18`：添加任务后没有清空输入框，导致连续提交重复任务。
- **HIGH** `src/components/TodoList.tsx:42`：删除任务后列表索引错误，偶发删错项。
- **MEDIUM** `src/App.tsx:23`：空列表时没有空状态提示。
- **MEDIUM** `src/components/TodoList.tsx:15`：任务文本过长时布局撑破容器。
- **MEDIUM** `src/types/todo.ts:4`：`completed` 字段没有默认值。
- **LOW** `src/App.tsx:30`：没有给 input 加 `aria-label`。
- **LOW** `src/hooks/useTodos.ts`：存在未使用的 import `useEffect`。

### 第 2 轮发现的问题

- **MEDIUM** `src/components/TodoList.tsx:38`：修复删除索引时漏了 `key` 取值，React key 仍用数组索引。
- **LOW** `src/App.tsx:45`：空状态文案可以更短。

### 回归检查清单

- [x] `npm run build` 通过
- [x] `npm run dev` 能启动
- [x] 添加任务后输入框清空
- [x] 删除任务不会删错
- [x] 空列表显示提示
- [x] 刷新页面任务不丢失（localStorage）
