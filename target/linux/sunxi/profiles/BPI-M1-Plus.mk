#
# Copyright (C) 2015 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

define Profile/BPI-M1-Plus
	NAME:=BPI-M1-Plus
	PACKAGES:=\
		uboot-sunxi-BPI-M1 uboot-sunxi-BPI-M1-Plus uboot-sunxi-BPI-R1 kmod-rtc-sunxi luci
endef

define Profile/BPI-M1-Plus/Description
	Package set optimized for the BPI-M1-Plus
endef

$(eval $(call Profile,BPI-M1-Plus))
