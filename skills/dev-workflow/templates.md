# 模板参考

## 交接文档模板（handoff-template.md）

```markdown
# Handoff Document

## 项目信息
- 项目名称: {{project_name}}
- 当前阶段: {{phase}} - {{phase_name}}
- 当前轮次: {{round}} - {{round_name}}
- 时间: {{date}}

## 已完成的工作
- {{completed_item_1}}
- {{completed_item_2}}

## 当前状态
- 代码分支: {{branch}}
- 已修改文件:
  - {{file_1}}
  - {{file_2}}
- 已知问题:
  - {{issue_1}}

## 下一步任务
- 阶段: {{next_phase}}
- 轮次: {{next_round}}
- 任务描述: {{next_task}}
- 需要修改的文件:
  - {{next_file_1}}
  - {{next_file_2}}
- 验收标准:
  - {{criterion_1}}
  - {{criterion_2}}

## 注意事项
- {{note_1}}
```

## 检测报告模板（review-report-template.md）

```markdown
# Review Report

## 被检测者
- 执行者: {{executor_name}}
- 任务: {{task}}
- 时间: {{date}}

## 检测结果
- 状态: 通过 / 不通过
- 问题数: {{issue_count}}

## 发现的问题
- [{{severity}}] {{file}}: {{description}}

## 建议修复
- {{file}}: {{action}}

## 验收标准
- [{{status}}] {{description}}
```

## 主 Agent 交接文档模板

```markdown
# 主 Agent 交接文档

## 项目信息
- 项目名称: {{project_name}}
- 当前阶段: {{phase}}
- 当前轮次: {{round}}
- 时间: {{date}}

## 已完成的工作
1. {{phase_summary_1}}
2. {{phase_summary_2}}

## 当前状态
- 正在进行的任务: {{current_task}}
- 执行者: {{executor}}
- 检测者: {{reviewer}}

## 下一步计划
- {{next_step_1}}
- {{next_step_2}}

## 已知问题
- {{known_issue}}

## 注意事项
- {{note}}
```

## 测试报告模板

```markdown
# Test Report

## 测试时间
{{datetime}}

## 测试结果
- 状态: 通过 / 失败
- 通过率: {{pass_rate}}

## 测试用例
| 用例 | 状态 | 备注 |
|------|------|------|
| {{case_name}} | {{status}} | {{note}} |

## 失败原因
- 用例: {{failed_case}}
- 错误: {{error_message}}
- 截图: {{screenshot_path}}

## 建议修复
1. {{fix_suggestion}}
```
