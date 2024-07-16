#!/bin/bash
#
# Copyright (c) 2020-2024 JE <https://gihub.com/JE668>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/JE668/Phicomm-K3-LEDE-Firmware-Lean
# File name: beta/diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)

# https://github.com/FenghenHome/lede
# https://github.com/coolsnowwolf/lede.git

# Uncomment a feed source
# sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# echo '添加SSR-Plus软件源'
# sed -i "/helloworld/d" "feeds.conf.default"
# echo "src-git helloworld https://github.com/fw876/helloworld.git" >> "feeds.conf.default"
# echo '=========Add SSR-Plus source OK!========='

echo '添加Passwall依赖feeds'
sed -i '$a src-git passwall https://github.com/xiaorouji/openwrt-passwall-packages' feeds.conf.default
echo '=========Add passwall feeds source OK!========='

echo '添加Passwall软件源'
rm -rf package/lean/luci-app-passwall 
git clone -b main --single-branch https://github.com/xiaorouji/openwrt-passwall package/lean/luci-app-passwall 
echo '=========Add passwall source OK!========='

echo '添加AdguardHome'
# rm -rf feeds/kiddin9/adguardhome
# rm -rf feeds/kiddin9/luci-app-adguardhome
# rm -rf package/feeds/kiddin9/luci-app-adguardhome
# rm -rf package/feeds/kiddin9/adguardhome
rm -rf package/lean/luci-app-adguardhome
git clone https://github.com/kongfl888/luci-app-adguardhome package/lean/luci-app-adguardhome 
echo '=========Add AdguardHome OK!========='

echo '添加lwz322的K3屏幕插件'
rm -rf package/lean/luci-app-k3screenctrl
git clone https://github.com/JE668/luci-app-k3screenctrl.git package/lean/luci-app-k3screenctrl
echo '=========Add k3screen plug OK!========='

echo '替换lwz322的K3屏幕驱动插件'
rm -rf package/lean/k3screenctrl
git clone https://github.com/JE668/k3screenctrl_build.git package/lean/k3screenctrl/
echo '=========Replace k3screen drive plug OK!========='



# echo '添加Haiibo软件源'
# sed -i '1i src-git haiibo https://github.com/haiibo/openwrt-packages' feeds.conf.default
# echo '=========Add Haiibo source OK!========='


# echo '添加kenzok8 small-package'
# echo 'src-git kenzok8 https://github.com/kenzok8/small-package' >>feeds.conf.default
# echo '=========Add kenzok8 source OK!========='

# echo '添加kiddin9软件源'
# echo 'src-git kiddin9 https://github.com/kiddin9/openwrt-packages' >>feeds.conf.default
# echo '=========Add kiddin9 source OK!========='
echo 'src-git mproxy https://github.com/chenzhen6666/luci-app-mproxy.git' >>feeds.conf.default


#1.'asus_dhd24' 2.'ac88u_20' 3.'69027'
firmware='69027'
echo '替换无线驱动'
wget -nv https://github.com/JE668/Phicomm-k3-Wireless-Firmware/raw/master/brcmfmac4366c-pcie.bin.${firmware} -O package/lean/k3-brcmfmac4366c-firmware/files/lib/firmware/brcm/brcmfmac4366c-pcie.bin
echo '=========Replace k3 wireless firmware OK!========='


#Compile K3 Only
sed -i 's|^TARGET_|# TARGET_|g; s|# TARGET_DEVICES += phicomm_k3|TARGET_DEVICES += phicomm_k3|' target/linux/bcm53xx/image/Makefile
