#!/bin/bash
# WebStatic初始化配置脚本

echo "🚀 WebStatic初始化配置"
echo "======================"
echo ""

read -p "请输入WebStatic Appkey (如: com.meituan.hotel.budget): " appkey
read -p "请输入部署域名 (如: hotel-budget-dashboard.webstatic.sankuai.com): " domain

cat > webstatic.config.json << EOF
{
  "appkey": "${appkey}",
  "domain": "https://${domain}",
  "project": "酒店客补预算监控看板",
  "owner": "岑翠妍",
  "update_frequency": "daily"
}
EOF

echo ""
echo "✅ 配置文件已创建: webstatic.config.json"
echo ""
echo "现在可以运行: ./webstatic-deploy.sh"
echo ""
