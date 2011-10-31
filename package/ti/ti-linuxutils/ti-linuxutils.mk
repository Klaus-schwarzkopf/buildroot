################################################################################
#
# ti-linuxutils
#
################################################################################
TI_LINUXUTILS_VERSION:=2.25.05.11
TI_LINUXUTILS_FILE_VERSION:=2_25_05_11
TI_LINUXUTILS_SOURCE = linuxutils_$(TI_LINUXUTILS_FILE_VERSION).tar.gz
TI_LINUXUTILS_SITE = http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/linuxutils/$(TI_LINUXUTILS_FILE_VERSION)/exports
TI_LINUXUTILS_DIR:=$(BUILD_DIR)/ti-linuxutils-$(TI_LINUXUTILS_VERSION)

TI_LINUXUTILS_INSTALL_STAGING = YES

TI_LINUXUTILS_INSTALL_STAGING_DIR=$(STAGING_DIR)/ti/linuxutils-$(TI_LINUXUTILS_VERSION)

TI_LINUXUTILS_DEPENDENCIES=linux

TI_LINUXUTILS_BUILD_MAKE_ARGS = \
	CC=$(TARGET_CC) \
	LD=$(TARGET_LD) \
	MVTOOL_PREFIX=$(TARGET_CROSS) \
	UCTOOL_PREFIX=$(TARGET_CROSS)\
	LINUXKERNEL_INSTALL_DIR=$(BUILD_DIR)/linux-$(LINUX_VERSION) \
	EXEC_DIR=$(TARGET_DIR)/usr/lib/ti-linuxutils

TI_LINUXUTILS_MODULES = cmem
ifeq ($(BR2_PACKAGE_TI_PLATFORM_omap3),y)
	TI_LINUXUTILS_MODULES += sdma
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_dm365),y)
	TI_LINUXUTILS_MODULES += edma irq
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_dm368),y)
	#TODO: Verify this
	TI_LINUXUTILS_MODULES += edma irq
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_dm355),y)
	TI_LINUXUTILS_MODULES += edma irq
endif

define TI_LINUXUTILS_BUILD_CMDS
	for i in $(TI_LINUXUTILS_MODULES) ; do \
		$(MAKE) $(TI_LINUXUTILS_BUILD_MAKE_ARGS) -C $(@D)/packages/ti/sdo/linuxutils/$$i clean debug release; \
	done
endef

define TI_LINUXUTILS_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(TI_LINUXUTILS_INSTALL_STAGING_DIR);
	cp -pPrf $(TI_LINUXUTILS_DIR)/* $(TI_LINUXUTILS_INSTALL_STAGING_DIR);
	chmod -R +w $(TI_LINUXUTILS_INSTALL_STAGING_DIR);
endef

define TI_LINUXUTILS_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/kernel/drivers/dsp
	for i in $(TI_LINUXUTILS_MODULES) ; do \
		$(INSTALL) -m 0644 $(@D)/packages/ti/sdo/linuxutils/$$i/src/module/$${i}k.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/kernel/drivers/dsp/$${i}k.ko ; \
		$(MAKE) $(TI_LINUXUTILS_BUILD_MAKE_ARGS) -C $(@D)/packages/ti/sdo/linuxutils/$${i} install ; \
	done
endef

$(eval $(call GENTARGETS,package/ti,ti-linuxutils))
