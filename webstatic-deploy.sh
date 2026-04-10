#!/bin/bash
# WebStatic 一键部署脚本
# 美团内网部署 - 酒店客补预算监控看板

echo "🏨 酒店客补预算监控看板 - WebStatic部署"
echo "========================================"
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# 检查是否在美团内网
if ! curl -s --connect-timeout 3 https://km.sankuai.com > /dev/null 2>&1; then
    echo -e "${RED}⚠️  警告：似乎不在美团内网环境${NC}"
    echo "WebStatic部署需要在内网进行"
    echo ""
fi

# 检查Node.js
if ! command -v node &> /dev/null; then
    echo -e "${RED}❌ 请先安装Node.js${NC}"
    echo "安装命令: brew install node"
    exit 1
fi

# 检查/安装WebStatic CLI
echo -e "${BLUE}📦 检查WebStatic CLI...${NC}"
if ! command -v webstatic &> /dev/null; then
    echo "正在安装 @meituan/webstatic-cli..."
    npm install -g @meituan/webstatic-cli
    if [ $? -ne 0 ]; then
        echo -e "${RED}❌ 安装失败，请检查npm配置${NC}"
        exit 1
    fi
fi

echo -e "${GREEN}✅ WebStatic CLI已就绪${NC}"
echo ""

# 显示部署选项
echo -e "${YELLOW}请选择部署方式：${NC}"
echo "1) 方式一：DevTools网页上传（推荐初次使用）"
echo "2) 方式二：命令行自动部署（需先配置appkey）"
echo "3) 查看部署指南"
echo ""
read -p "请输入选项 (1/2/3): " choice

case $choice in
    1)
        echo ""
        echo -e "${GREEN}👉 请打开浏览器访问：${NC}"
        echo -e "${BLUE}https://devtools.sankuai.com${NC}"
        echo ""
        echo "操作步骤："
        echo "1. 登录后选择您的项目"
        echo "2. 选择 'WebStatic部署' 模式"
        echo "3. 拖拽当前文件夹上传"
        echo "4. 点击发布"
        echo ""
        echo -e "${YELLOW}当前文件夹路径：${NC}$(pwd)"
        ;;
    2)
        echo ""
        # 检查配置文件
        if [ -f "webstatic.config.json" ]; then
            APPKEY=$(cat webstatic.config.json | grep -o '"appkey": "[^"]*"' | cut -d'"' -f4)
            echo -e "${GREEN}✅ 找到配置文件，appkey: $APPKEY${NC}"
            echo ""
            read -p "确认部署到生产环境? (y/n): " confirm
            if [ "$confirm" = "y" ]; then
                echo ""
                echo -e "${BLUE}🚀 开始部署...${NC}"
                webstatic deploy --appkey "$APPKEY" --source ./ --env prod
                if [ $? -eq 0 ]; then
                    echo ""
                    echo -e "${GREEN}✅ 部署成功！${NC}"
                    echo ""
                    echo -e "${YELLOW}🌐 访问地址（部署完成后10分钟内生效）：${NC}"
                    cat webstatic.config.json | grep -o '"domain": "[^"]*"' | cut -d'"' -f4
                else
                    echo ""
                    echo -e "${RED}❌ 部署失败${NC}"
                    echo "请检查：1) 是否已登录内网 2) appkey是否正确 3) 网络连接"
                fi
            fi
        else
            echo -e "${YELLOW}⚠️  未找到配置文件${NC}"
            echo "请先完成以下步骤："
            echo ""
            echo "1. 在Pingpang平台创建应用: https://pp.sankuai.com"
            echo "2. 在Oceanus配置站点: https://oceanus.mws.sankuai.com"
            echo "3. 获取appkey后，运行：./init-webstatic.sh"
        fi
        ;;
    3)
        cat WEBSTATIC-QUICKSTART.md
        ;;
    *)
        echo "无效选项"
        ;;
esac
