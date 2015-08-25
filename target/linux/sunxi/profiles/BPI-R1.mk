#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/BPI-R1
	NAME:=BPI-R1
	PACKAGES:=\
		uboot-sunxi-BPI-M1 uboot-sunxi-BPI-M1-Plus uboot-sunxi-BPI-R1 kmod-ata-sunxi kmod-rtl8192cu \
		swconfig wpad-mini luci
endef

define Profile/BPI-R1/Description
	Package set optimized for the BPI-R1
endef

$(eval $(call Profile,BPI-R1))
