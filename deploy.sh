#!/bin/bash
# 一键部署脚本 - 客补预算监控看板
# 用户名: smiledandelion0906

GITHUB_USER="smiledandelion0906"
REPO_NAME="hotel-budget-dashboard"
GITHUB_URL="https://github.com/${GITHUB_USER}/${REPO_NAME}.git"

echo "🏨 酒店客补预算监控看板 - 一键部署"
echo "==================================="
echo "GitHub用户: ${GITHUB_USER}"
echo "仓库名称: ${REPO_NAME}"
echo ""

# 检查git
if ! command -v git &> /dev/null; then
    echo "❌ 请先安装git: brew install git"
    exit 1
fi

# 配置git（如果没有）
if ! git config --global user.name &> /dev/null; then
    git config --global user.name "${GITHUB_USER}"
    git config --global user.email "${GITHUB_USER}@users.noreply.github.com"
    echo "✅ Git配置完成"
fi

# 初始化git仓库
echo ""
echo "📦 初始化Git仓库..."
if [ ! -d ".git" ]; then
    git init
    git add .
    git commit -m "init: 客补预算监控看板 v1.0"
    echo "✅ Git仓库初始化完成"
else
    echo "✅ Git仓库已存在"
fi

# 关联远程仓库
echo ""
echo "🔗 关联远程仓库..."
echo "   ${GITHUB_URL}"
git remote add origin "$GITHUB_URL" 2>/dev/null || git remote set-url origin "$GITHUB_URL"

# 检查GitHub仓库是否存在
echo ""
echo "📝 重要提示"
echo "-----------"
echo "请确保您已在GitHub创建仓库:"
echo ""
echo "👉 快速创建链接:"
echo "   https://github.com/new?name=${REPO_NAME}&visibility=public"
echo ""
read -p "已创建仓库? 按回车继续..."

# 推送代码
echo ""
echo "📤 推送代码到GitHub..."
git branch -M main
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 代码推送成功！"
    echo ""
    echo "🌐 下一步：启用GitHub Pages"
    echo "---------------------------"
    echo "1. 打开: https://github.com/${GITHUB_USER}/${REPO_NAME}/settings/pages"
    echo "2. Source 选择 'Deploy from a branch'"
    echo "3. Branch 选择 'main'，folder选择 '/ (root)'"
    echo "4. 点击 Save"
    echo "5. 等待2-5分钟"
    echo ""
    echo "📱 您的看板地址:"
    echo "   https://${GITHUB_USER}.github.io/${REPO_NAME}"
    echo ""
    echo "🎉 部署完成后即可访问！"
else
    echo ""
    echo "❌ 推送失败，常见原因:"
    echo "   1. GitHub仓库未创建"
    echo "   2. 未登录GitHub账号"
    echo "   3. 网络连接问题"
    echo ""
    echo "💡 解决方法:"
    echo "   - 访问 https://github.com/${GITHUB_USER}/${REPO_NAME} 确认仓库存在"
    echo "   - 运行 'gh auth login' 登录GitHub CLI"
fi
