#!/bin/bash
# GitHub Pages 自动部署脚本
# 使用方式: GITHUB_TOKEN=your_token bash auto-deploy-github.sh

set -e

echo "🏨 酒店客补预算监控看板 - 自动部署"
echo "=================================="
echo ""

# 配置
GITHUB_USER="smiledandelion0906"
REPO_NAME="hotel-budget-dashboard"

# 从环境变量读取token
if [ -z "$GITHUB_TOKEN" ]; then
    echo "❌ 请设置环境变量: export GITHUB_TOKEN=your_token"
    exit 1
fi

# 颜色
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

# 检查git
if ! command -v git &> /dev/null; then
    echo "❌ 请先安装git: brew install git"
    exit 1
fi

# 配置git
git config --global user.name "${GITHUB_USER}"
git config --global user.email "${GITHUB_USER}@users.noreply.github.com"

echo -e "${BLUE}📦 步骤1/4: 创建GitHub仓库...${NC}"

# 创建仓库（如果不存在）
curl -s -X POST \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/user/repos \
  -d "{\"name\":\"${REPO_NAME}\",\"private\":false}" > /dev/null 2>&1 || true

sleep 2

echo -e "${BLUE}📦 步骤2/4: 初始化Git仓库...${NC}"

# 初始化git
rm -rf .git
git init
git add .
git commit -m "Initial commit: 酒店客补预算监控看板"

echo -e "${BLUE}📦 步骤3/4: 推送到GitHub...${NC}"

# 添加远程仓库并推送
git remote add origin "https://${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${REPO_NAME}.git" 2>/dev/null || \
git remote set-url origin "https://${GITHUB_TOKEN}@github.com/${GITHUB_USER}/${REPO_NAME}.git"

git branch -M main
git push -f origin main

echo -e "${BLUE}📦 步骤4/4: 启用GitHub Pages...${NC}"

# 启用GitHub Pages
curl -s -X POST \
  -H "Authorization: token ${GITHUB_TOKEN}" \
  -H "Accept: application/vnd.github.v3+json" \
  https://api.github.com/repos/${GITHUB_USER}/${REPO_NAME}/pages \
  -d '{"source":{"branch":"main","path":"/"}}' > /dev/null 2>&1 || true

echo ""
echo -e "${GREEN}✅ 部署完成！${NC}"
echo ""
echo -e "${YELLOW}🌐 访问地址（2-3分钟后生效）：${NC}"
echo -e "${BLUE}https://${GITHUB_USER}.github.io/${REPO_NAME}/${NC}"
echo ""
echo "⏰ 如果现在还看不到，请等待2-3分钟后刷新"
echo ""
echo "📱 分享链接给团队成员即可访问！"
