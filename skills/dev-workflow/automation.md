# 自动化验证参考

## 自动化测试脚本

位置：`scripts/test.sh`（项目根目录，需自行创建）

根据项目类型选择对应的验证命令：

```bash
#!/bin/bash
set -e

echo "开始自动化测试..."

# === 根据项目类型选择 ===

# Node.js 项目
npm run build
npm start &
APP_PID=$!
sleep 5
npx playwright test
kill $APP_PID

# Python 项目
# pip install -e .
# pytest
# python -m app &
# APP_PID=$!
# sleep 5
# pytest tests/e2e/
# kill $APP_PID

# Rust 项目
# cargo build
# cargo run &
# APP_PID=$!
# sleep 5
# cargo test
# kill $APP_PID

echo "自动化测试通过！"
```

## Playwright 测试用例示例

```javascript
const { test, expect } = require('@playwright/test');

test('basic flow', async ({ page }) => {
  await page.goto('http://localhost:3000');
  await expect(page).toHaveTitle(/AppName/);

  // 登录
  await page.fill('[data-testid="email-input"]', 'test@example.com');
  await page.fill('[data-testid="password-input"]', 'password123');
  await page.click('[data-testid="login-button"]');
  await expect(page).toHaveURL(/dashboard/);

  // 核心功能
  await page.click('[data-testid="new-report-button"]');
  await expect(page.locator('[data-testid="report-form"]')).toBeVisible();
});
```

## 运行时验证清单

- [ ] 编译成功
- [ ] 应用能启动
- [ ] 页面能加载
- [ ] 登录流程正常
- [ ] 核心功能正常（创建 → 保存 → 查看）
- [ ] 错误处理正常
- [ ] 导航正常
- [ ] 空状态正常

## 失败回滚

测试失败时，不要直接 `git reset --hard`（会丢失未提交的改动）。推荐做法：

```bash
#!/bin/bash
echo "测试失败，开始回滚..."
# 1. 先查看失败时的改动，方便调试
git diff --stat
# 2. 用 stash 保存当前改动（可恢复）
git stash push -m "failed-test-$(date +%s)"
# 3. 回到上一个可工作状态
git checkout -- .
# 4. 重新编译和测试
echo "回滚完成！可用 git stash list 查看保存的改动。"
```

回滚触发条件：编译失败、应用无法启动、测试失败、功能流程走不通。
