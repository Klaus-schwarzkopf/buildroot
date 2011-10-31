################################################################################
#
# ti-dsplink
#
################################################################################
TI_DSPLINK_VERSION:=1.65.00.03
TI_DSPLINK_FILE_VERSION_MAJOR:=1_65
TI_DSPLINK_FILE_VERSION:=$(TI_DSPLINK_FILE_VERSION_MAJOR)_00_03
TI_DSPLINK_SOURCE = dsplink_linux_$(TI_DSPLINK_FILE_VERSION).tar.gz
TI_DSPLINK_SITE = http://software-dl.ti.com/dsps/dsps_public_sw/DSPLink/$(TI_DSPLINK_FILE_VERSION_MAJOR)/$(TI_DSPLINK_FILE_VERSION)/$(TI_DSPLINK_VERSION)
TI_DSPLINK_DIR:=$(BUILD_DIR)/ti-dsplink-$(TI_DSPLINK_VERSION)
TI_DSPLINK_PATH:=$(TI_DSPLINK_DIR)/dsplink

TI_DSPLINK_INSTALL_STAGING = YES

TI_DSPLINK_DEPENDENCIES = ti-xdctools ti-dspbios linux

TI_DSPLINK_INSTALL_STAGING_DIR=$(STAGING_DIR)/ti/dsplink-$(TI_DSPLINK_VERSION)/packages

TI_DSPLINK_DSPNUM=1
TI_DSPLINK_DSP_COMP=ponslrmc
TI_DSPLINK_DSPPOS=DSPBIOS5XX
TI_DSPLINK_PLATFORM=UNDEFINED
TI_DSPLINK_DSPCFG=UNDEFINED
TI_DSPLINK_DSP=UNDEFINED
TI_DSPLINK_GPPOS=UNDEFINED
ifeq ($(BR2_PACKAGE_TI_PLATFORM_omap3),y)
	TI_DSPLINK_PLATFORM=OMAP3530
	TI_DSPLINK_DSPCFG=OMAP3530SHMEM
	TI_DSPLINK_DSP=OMAP3530_0
	TI_DSPLINK_GPPOS=OMAPLSP
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_dm6446),y)
	TI_DSPLINK_PLATFORM=DAVINCI
	TI_DSPLINK_DSPCFG=DM6446GEMSHMEM
	TI_DSPLINK_DSP=DM6446GEM_0
	TI_DSPLINK_GPPOS=DM6446LSP
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_dm6467),y)
	TI_DSPLINK_PLATFORM=DAVINCIHD
	TI_DSPLINK_DSPCFG=DM6467GEMSHMEM
	TI_DSPLINK_DSP=DM6467GEM_0
	TI_DSPLINK_GPPOS=DM6467LSP
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_omapl137),y)
	TI_DSPLINK_PLATFORM=OMAPL1XX
	TI_DSPLINK_DSPCFG=OMAPL1XXGEMSHMEM
	TI_DSPLINK_DSP=OMAPL1XXGEM_0
	TI_DSPLINK_GPPOS=ARM
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_omapl138),y)
	TI_DSPLINK_PLATFORM=OMAPL138
	TI_DSPLINK_DSPCFG=OMAPL138GEMSHMEM
	TI_DSPLINK_DSP=OMAPL138GEM_0
	TI_DSPLINK_GPPOS=ARM
endif


define TI_DSPLINK_CONFIGURE_CMDS
	(export DSPLINK=$(TI_DSPLINK_PATH); \
	 export C_FLAGS="$(TARGET_CFLAGS) -fPIC"; \
	 export LD_FLAGS ="$(TARGET_LDFLAGS)";  \
		/usr/bin/perl $(TI_DSPLINK_PATH)/config/bin/dsplinkcfg.pl \
			--platform=$(TI_DSPLINK_PLATFORM) \
			--nodsp=$(TI_DSPLINK_DSPNUM) \
			--dspcfg_0=$(TI_DSPLINK_DSPCFG) \
			--dspos_0=$(TI_DSPLINK_DSPPOS) \
			--comps=$(TI_DSPLINK_DSP_COMP) \
			--gppos=$(TI_DSPLINK_GPPOS) \
	)
	(cd $(TI_DSPLINK_PATH); XDCPATH=$(TI_XDCTOOLS_INSTALL_DIR) $(TI_XDCTOOLS_INSTALL_DIR)/xdc .make -PR .)
	(cd $(TI_DSPLINK_PATH); XDCPATH=$(TI_XDCTOOLS_INSTALL_DIR) $(TI_XDCTOOLS_INSTALL_DIR)/xdc clean -PR .)
	(cd $(TI_DSPLINK_PATH); XDCPATH=$(TI_XDCTOOLS_INSTALL_DIR) $(TI_XDCTOOLS_INSTALL_DIR)/xdc .interfaces -PR .)
endef

define TI_DSPLINK_BUILD_CMDS
 	$(MAKE1) -C $(TI_DSPLINK_PATH)/gpp/src/api \
		DSPLINK=$(TI_DSPLINK_PATH) \
		CROSS_COMPILE="$(TOOLCHAIN_EXTERNAL_PREFIX)" \
		AR="$(TARGET_CROSS)ar" \
		LD="$(TARGET_LD)" \
		COMPILER="$(TARGET_CC)" \
		ARCHIVER="$(TARGET_CROSS)ar" \
 		KERNEL_DIR="$(BUILD_DIR)/linux-$(LINUX_VERSION)" \
 			all
	# Build the gpp kernel space (debug and release)
	$(MAKE1) -C $(TI_DSPLINK_PATH)/gpp/src \
		DSPLINK=$(TI_DSPLINK_PATH) \
		OBJDUMP="$(TARGET_CROSS)objdump" \
		CROSS_COMPILE="$(TARGET_CROSS)" \
		CC="$(TARGET_CC)" \
		AR="$(TARGET_CROSS)ar" \
		LD="$(TARGET_LD)" \
		COMPILER="$(TARGET_CC)" \
		ARCHIVER="$(TARGET_CROSS)ar" \
		KERNEL_DIR="$(BUILD_DIR)/linux-$(LINUX_VERSION)" \
		BASE_BUILDOS="$(BUILD_DIR)/linux-$(LINUX_VERSION)" \
			all
	# Build the dsp library (debug and release)
 	$(MAKE) -C $(TI_DSPLINK_PATH)/dsp/src \
		DSPLINK=$(TI_DSPLINK_PATH) \
 		BASE_CGTOOLS="$(TI_CGT6X_INSTALL_DIR)" \
		BASE_SABIOS="$(TI_DSPBIOS_INSTALL_DIR)" \
			all
endef

define TI_DSPLINK_INSTALL_STAGING_CMDS
	# Install/Stage the Source Tree
	$(INSTALL) -d $(TI_DSPLINK_INSTALL_STAGING_DIR)
	cp -pPrf $(TI_DSPLINK_DIR)/* $(TI_DSPLINK_INSTALL_STAGING_DIR)
	chmod -R +w $(TI_DSPLINK_INSTALL_STAGING_DIR)

	# Changes path of include txt file to use LINK_INSTALL_DIR variable for GPP
	i_find=`find $(TI_DSPLINK_INSTALL_STAGING_DIR)/dsplink/gpp/export/BIN/Linux/$(TI_DSPLINK_PLATFORM)/*/ -name "*.txt"` ; \
	for i in $$i_find; do \
		sed -i $$i -e s=$(TI_DSPLINK_PATH)=$(TI_DSPLINK_INSTALL_STAGING_DIR)=g ; \
  done; 

	#Changes path of include txt file to use LINK_INSTALL_DIR variable for DSP 
	i_find=`find $(TI_DSPLINK_INSTALL_STAGING_DIR)/dsplink/dsp/export/BIN/DspBios/$(TI_DSPLINK_PLATFORM)/$(TI_DSPLINK_DSP)/*/ -name "*.txt"` ; \
	for i in $$i_find; do \
		sed -i $$i -e s=$(TI_DSPLINK_PATH)=$(TI_DSPLINK_INSTALL_STAGING_DIR)=g ; \
  done ;
endef

define TI_DSPLINK_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/kernel/drivers/dsp
	$(INSTALL) -m 0644 $(TI_DSPLINK_PATH)/gpp/export/BIN/Linux/$(TI_DSPLINK_PLATFORM)/RELEASE/dsplinkk.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/kernel/drivers/dsp/dsplinkk.ko
endef

define TI_DSPLINK_UNINSTALL_TARGET_CMDS
	rm -rf $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/kernel/drivers/dsp/dsplinkk.ko
endef


$(eval $(call GENTARGETS,package/ti,ti-dsplink))

