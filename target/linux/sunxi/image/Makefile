#
# Copyright (C) 2013 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
include $(TOPDIR)/rules.mk
include $(INCLUDE_DIR)/image.mk
include $(INCLUDE_DIR)/host.mk

FAT32_BLOCK_SIZE=1024
FAT32_BLOCKS=$(shell echo $$(($(CONFIG_SUNXI_SD_BOOT_PARTSIZE)*1024*1024/$(FAT32_BLOCK_SIZE))))

BOARDS:= \
	sun7i-a20-bpi-m1 \
	sun7i-a20-bpi-m1-plus \
	sun7i-a20-bpi-r1

define Image/BuildKernel
	mkimage -A arm -O linux -T kernel -C none \
		-a 0x40008000 -e 0x40008000 \
		-n 'ARM OpenWrt Linux-$(LINUX_VERSION)' \
		-d $(KDIR)/zImage $(BIN_DIR)/$(IMG_PREFIX)-uImage
	
    ifneq ($(CONFIG_TARGET_ROOTFS_INITRAMFS),)
	$(CP) $(KDIR)/zImage-initramfs $(BIN_DIR)/$(IMG_PREFIX)-zImage-initramfs
	echo -ne '\x00\x00\x00\x00' >> $(BIN_DIR)/$(IMG_PREFIX)-zImage-initramfs
	$(call Image/BuildKernel/MkuImage, \
		none, 0x40008000, 0x40008000, \
		$(BIN_DIR)/$(IMG_PREFIX)-zImage-initramfs, \
		$(BIN_DIR)/$(IMG_PREFIX)-uImage-initramfs \
	)
    endif

	$(foreach board,$(BOARDS),
		$(CP) $(DTS_DIR)/$(board).dtb $(BIN_DIR)/
	)
endef

ifeq ($(PROFILE),BPI-M1)
        jx=BPI-M1
endif
ifeq ($(PROFILE),BPI-M1-Plus)
        jx=BPI-M1-Plus
endif
ifeq ($(PROFILE),BPI-R1)
        jx=BPI-R1
endif

define Image/Build/SDCard
	rm -f $(KDIR)/boot.img
	mkdosfs $(KDIR)/boot.img -C $(FAT32_BLOCKS)
	
	mcopy -i $(KDIR)/boot.img $(BIN_DIR)/uboot-sunxi-$(PROFILE)/$(IMG_PREFIX)-$(PROFILE)-boot.scr ::boot.scr
	mcopy -i $(KDIR)/boot.img $(BIN_DIR)/$(2).dtb ::dtb
	mcopy -i $(KDIR)/boot.img $(BIN_DIR)/$(IMG_PREFIX)-uImage ::uImage
	
	./gen_sunxi_sdcard_img.sh \
		$(BIN_DIR)/$(IMG_PREFIX)-$(jx)-sdcard-vfat-$(1).img \
		$(KDIR)/boot.img \
		$(KDIR)/root.$(1) \
		$(CONFIG_SUNXI_SD_BOOT_PARTSIZE) \
		$(CONFIG_TARGET_ROOTFS_PARTSIZE) \
		$(BIN_DIR)/uboot-sunxi-$(PROFILE)/$(IMG_PREFIX)-$(PROFILE)-u-boot-with-spl.bin
endef

define Image/Build/Profile/BPI-M1
	$(call Image/Build/SDCard,$(1),sun7i-a20-bpi-m1)
endef

define Image/Build/Profile/BPI-M1-Plus
	$(call Image/Build/SDCard,$(1),sun7i-a20-bpi-m1-plus)
endef

define Image/Build/Profile/BPI-R1
	$(call Image/Build/SDCard,$(1),sun7i-a20-bpi-r1)
endef

define Image/Build
	$(call Image/Build/$(1),$(1))
	$(call Image/Build/Profile/$(PROFILE),$(1))
	
	dd if=$(KDIR)/root.$(1) of=$(BIN_DIR)/$(IMG_PREFIX)-root.$(1) bs=128k conv=sync
endef

$(eval $(call BuildImage))
