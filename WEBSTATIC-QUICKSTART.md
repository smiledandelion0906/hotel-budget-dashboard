# 🚀 WebStatic快速部署指南

## 3步完成部署

### 第1步：申请WebStatic资源（5分钟）

#### 1.1 创建前端应用
- 打开 👉 https://pp.sankuai.com
- 点击「创建应用」
- 填写：
  - 应用名称：`酒店客补预算监控看板`
  - 应用类型：Web应用
  - 所属部门：您的部门
- 提交后获得 **Appkey**（如：`com.meituan.hotel.budget.dashboard`）

#### 1.2 配置WebStatic站点
- 打开 👉 https://oceanus.mws.sankuai.com
- 点击「创建站点」
- 填写：
  - 站点名称：`hotel-budget-dashboard`
  - 类型：WebStatic
  - 关联Appkey：选择刚创建的
- 系统自动生成域名（如：`hotel-budget-dashboard.webstatic.sankuai.com`）

### 第2步：初始化配置（1分钟）

在终端运行：
```bash
./init-webstatic.sh
```
按提示输入：
- Appkey：上面获取的
- 域名：上面生成的

### 第3步：部署上线（1分钟）

```bash
./webstatic-deploy.sh
```

选择 `2) 命令行自动部署`，确认后自动上传！

---

## 🌐 访问看板

部署成功后访问：
```
https://hotel-budget-dashboard.webstatic.sankuai.com
```

分享给团队成员即可！

---

## 📊 数据更新流程

### 手动更新（推荐初期）

每天执行：
```bash
# 1. 编辑 data.json 更新数据
# 2. 重新部署
./webstatic-deploy.sh
```

### 自动化（可选）

配置定时任务或接入数据平台自动更新。

---

## 📋 需要记录的信息

创建 `DEPLOY_INFO.txt` 记录以下信息，方便后续维护：

```
项目名称：酒店客补预算监控看板
Pingpang Appkey：com.meituan.hotel.budget.dashboard
访问域名：https://hotel-budget-dashboard.webstatic.sankuai.com
负责人：岑翠妍 (mis账号)
创建日期：2025-04-09
```

---

## ❓ 遇到问题？

| 问题 | 解决方式 |
|------|----------|
| 无法访问pp.sankuai.com | 确认在内网环境，或连接美团VPN |
| 部署失败 | 检查appkey是否正确，重新运行init-webstatic.sh |
| 页面显示404 | 确保index.html在根目录 |
| 数据没更新 | 清除浏览器缓存，确认data.json已上传 |

**技术支持**：
- WebStatic文档：https://km.sankuai.com/page/747885834
- 技术群：TT群搜索 "WebStatic"
