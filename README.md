# BPI-OpenWRT
Supports BananaPi BPI -M1 / M1Plus / R1 /

1. Pre-Install Tools：
```
apt-get install subversion build-essential libncurses5-dev zlib1g-dev gawk git ccache gettext libssl-dev xsltproc unzip subversion file
```
2. Sync update
```
./scripts/feeds update -a
./scripts/feeds install -a
```
3. Run `make` commmand

4. Compiled successfully，go to `bin/sunix/` under the directory, you can find `openwrt-sunxi-BPI-XX-sdcard-vfat-ext4.img`，Writing in SD Card.


**Notes：**
+  Defualt account/password：`root/admin`
+  Port 22 and Port 80 , turned on by default
+  "wan" as the default name for BPI-M1 and BPI-M1-Plus wired networks.
+  `BPI-M1-Plus` onboard wifi (Broadcom-AP6181) doesn't support this feature yet. You may go with USB dongle wifi.
