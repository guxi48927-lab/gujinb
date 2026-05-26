#!/bin/bash
clear
echo -e "\033[33m"
echo " ██████╗ ██╗   ██╗███████╗██╗███╗   ██╗███████╗███████╗███████╗"
echo "██╔════╝ ██║   ██║██╔════╝██║████╗  ██║██╔════╝██╔════╝██╔════╝"
echo "██║  ███╗██║   ██║█████╗  ██║██╔██╗ ██║█████╗  ███████╗█████╗  "
echo "██║   ██║██║   ██║██╔══╝  ██║██║╚██╗ ██║██╔══╝  ╚════██║██╔══╝  "
echo "╚██████╔╝╚██████╔╝███████║██║██║ ╚████║███████╗███████║███████╗"
echo " ╚═════╝  ╚═════╝ ╚══════╝╚═╝╚═╝  ╚═══╝╚══════╝╚══════╝╚══════╝"
echo -e "\033[0m"
echo -e "\033[36m=============== GUJINB666 专用卡密系统 v1.11 ===============\033[0m"
echo ""

echo -e "\033[35m请输入卡密：\033[0m"
read -s INPUT_KEY

c1="G"
c2="J"
c3="M"
c4="M"
c5="N"
c6="B"
c7="6"
c8="6"
c9="6"
c10="W"
c11="S"
c12="X"
c13="G"
c14="W"
c15="W"
c16="W"
key="$c1$c2$c3$c4$c5$c6$c7$c8$c9$c10$c11$c12$c13$c14$c15$c16"

if [ "$INPUT_KEY" != "$key" ]; then
    echo -e "\033[31m❌ 卡密错误！退出程序\033[0m"
    exit 1
fi

echo -e "\033[32m✅ 卡密正确，开始执行...\033[0m"
sleep 1
clear

cd "$(dirname "$0")" || exit 1

# ====================== 版本配置 ======================
LOCAL_VER="v1.11"
VER_URL="https://raw.githubusercontent.com/guxi48927-lab/gujinb/main/version.txt"
UPDATE_URL="https://raw.githubusercontent.com/guxi48927-lab/gujinb/main/版本/替换终端.sh"
MY_PID=$$
OLD_FILE="$0"
NEW_FILE="替换${LOCAL_VER}终端.sh"
# ======================================================

SRC="./config.json"
DST_DIR="/storage/emulated/0/Android/data/com.pi.czrxdfirst/files"
DST="$DST_DIR/config.json"
BAK_DIR="/storage/emulated/0/备份"
BAK_FILE="$BAK_DIR/config.json"

URL_V1="https://raw.githubusercontent.com/guxi48927-lab/gujinb/main/v1/config.json"
URL_V2="https://raw.githubusercontent.com/guxi48927-lab/gujinb/main/v2/config.json"

# ====================== 检测更新 ======================
echo -e "\033[36m📌 当前版本：$LOCAL_VER\033[0m"
echo -e "\033[33m🔍 正在检测更新...\033[0m"

ONLINE_VER=""
if command -v curl >/dev/null 2>&1; then
  ONLINE_VER=$(curl -s --connect-timeout 3 "$VER_URL" 2>/dev/null | tr -d '\r\n' || echo "")
elif command -v wget >/dev/null 2>&1; then
  ONLINE_VER=$(wget -q --timeout=3 -O - "$VER_URL" 2>/dev/null | tr -d '\r\n' || echo "")
fi

if [ -n "$ONLINE_VER" ] && [ "$ONLINE_VER" != "$LOCAL_VER" ]; then
  clear
  echo -e "\033[31m⚠️  发现新版本：$ONLINE_VER\033[0m"
  echo -e "\033[33m📌 当前版本：$LOCAL_VER\033[0m"
  echo ""
  echo -e "\033[36m是否更新？[Y/N] 默认N\033[0m"
  echo -e "\033[35m请输入选择：\033[0m"
  read yn

  if [ -z "$yn" ] || [ "$yn" = "N" ] || [ "$yn" = "n" ]; then
    echo -e "\033[31m已选择不更新，自动退出\033[0m"
    sleep 2
    exit 1
  fi

  if [ "$yn" = "Y" ] || [ "$yn" = "y" ]; then
    echo -e "\033[33m⏬ 正在下载最新终端..."
    if command -v curl >/dev/null 2>&1; then
      curl -L -o "$NEW_FILE" "$UPDATE_URL"
    elif command -v wget >/dev/null 2>&1; then
      wget -O "$NEW_FILE" "$UPDATE_URL"
    fi

    if [ -f "$NEW_FILE" ]; then
      chmod +x "$NEW_FILE"
      rm -f "$OLD_FILE"
      echo -e "\033[32m✅ 更新完成！新文件：$NEW_FILE\033[0m"
      echo -e "\033[33m请打开新文件使用！\033[0m"
    else
      echo -e "\033[31m❌ 更新失败！\033[0m"
    fi
    sleep 3
    exit 0
  fi
else
  echo -e "\033[32m✅ 已是最新版本\033[0m"
  sleep 1
fi
# ======================================================

while true; do
clear
echo -e "\033[36m=============== 顾鸡参数管理菜单（双版本通用）===============\033[0m"
echo -e "\033[32m📌 PID：$MY_PID   版本：$LOCAL_VER\033[0m"
echo ""
echo -e "\033[33m1 → 备份原有参数\033[0m"
echo -e "\033[33m2 → 删除现有参数\033[0m"
echo -e "\033[33m3 → 自动替换并选择版本\033[0m"
echo -e "\033[33m4 → 进入TG官方频道[记得挂梯子]\033[0m"
echo -e "\033[33m0 → 退出脚本\033[0m"
echo ""
echo -e "\033[35m请输入选项[0-4]：\033[0m"
read OPT

case $OPT in
1)
mkdir -p "$BAK_DIR"
if [ -f "$DST" ]; then
cp -f "$DST" "$BAK_FILE"
echo -e "\033[32m✅ 备份成功\033[0m"
else
echo -e "\033[31m❌ 无文件可备份\033[0m"
fi
sleep 2
;;

2)
if [ -f "$DST" ]; then
rm -f "$DST"
echo -e "\033[32m✅ 删除完成\033[0m"
else
echo -e "\033[31m❌ 无文件可删除\033[0m"
fi
sleep 2
;;

3)
clear
echo -e "\033[36m=============== 请选择参数版本 ===============\033[0m"
echo ""
echo -e "\033[33m1 → 下载并使用 V1 参数\033[0m"
echo -e "\033[33m2 → 下载并使用 V2 参数\033[0m"
echo ""
echo -n -e "\033[35m请选择版本：\033[0m"
read VER

if [ "$VER" = "1" ]; then
echo -e "\033[35m请输入V1专用密码：\033[0m"
read -s V1_PWD
if [ "$V1_PWD" != "FJZHUANSHUV1" ]; then
echo -e "\033[31m❌ V1密码错误！\033[0m"
sleep 2
continue
fi
DOWNLOAD_URL="$URL_V1"
TIP="by:反季 v1无敌参数"

elif [ "$VER" = "2" ]; then
echo -e "\033[35m请输入V2专用密码：\033[0m"
read -s V2_PWD
if [ "$V2_PWD" != "GJZHUANSHUV2" ]; then
echo -e "\033[31m❌ V2密码错误！\033[0m"
sleep 2
continue
fi
DOWNLOAD_URL="$URL_V2"
TIP="by:顾鸡 v2超准参数"

else
echo -e "\033[31m❌ 输入错误，返回菜单\033[0m"
sleep 2
continue
fi

echo -e "\033[33m⏬ 正在下载对应版本参数...\033[0m"
if command -v curl >/dev/null 2>&1; then
curl -L -o "$SRC" "$DOWNLOAD_URL"
elif command -v wget >/dev/null 2>&1; then
wget -O "$SRC" "$DOWNLOAD_URL"
else
echo -e "\033[31m❌ 终端没有下载工具，无法操作\033[0m"
sleep 3
continue
fi

if [ ! -f "$SRC" ]; then
echo -e "\033[31m❌ 下载失败\033[0m"
sleep 2
continue
fi

mkdir -p "$DST_DIR"
cp -f "$SRC" "$DST"
rm -f "$SRC"

clear
echo "--------------------------------------------------------------------"
echo "感谢尊敬的客户购买了顾鸡的参数 顾鸡的终端已为您自动替换文件！"
echo "$TIP"
echo "祝您稳定奔放 早日登上全国淘汰榜第一 一辈子不封 感谢您的信任"
echo "--------------------------------------------------------------------"
sleep 3
exit 0
;;

4)
echo -e "\033[32m🚀 正在打开TG频道...\033[0m"
echo -e "\033[33m⚠️  请确保已挂梯子\033[0m"
sleep 1
am start -a android.intent.action.VIEW -d "https://t.me/GJNBOVO" org.telegram.messenger
sleep 2
;;

0)
echo -e "\033[36m👋 已退出\033[0m"
exit 0
;;

*)
echo -e "\033[31m❌ 输入错误\033[0m"
sleep 1
;;
esac
done
