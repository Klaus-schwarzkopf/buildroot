################################################################################
#
# ti-codec-engine
#
################################################################################
TI_CODEC_ENGINE_VERSION:=2.25.05.16
TI_CODEC_ENGINE_FILE_VERSION:=2_25_05_16
TI_CODEC_ENGINE_SOURCE = codec_engine_$(TI_CODEC_ENGINE_FILE_VERSION),lite.tar.gz
TI_CODEC_ENGINE_SITE = http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/ce/$(TI_CODEC_ENGINE_FILE_VERSION)/exports
TI_CODEC_ENGINE_DIR:=$(BUILD_DIR)/ti-codec-engine-$(TI_CODEC_ENGINE_VERSION)

TI_CODEC_ENGINE_INSTALL_STAGING = YES
ifeq ($(BR2_PACKAGE_TI_CODEC_ENGINE_EXAMPLES),y)
	TI_CODEC_ENGINE_INSTALL_TARGET = YES
else
	TI_CODEC_ENGINE_INSTALL_TARGET = NO
endif

TI_CODEC_ENGINE_DEPENDENCIES = \
	ti-framework-components \
	ti-xdais \
	ti-xdctools \
	ti-linuxutils \
	ti-dspbios \
	ti-cgt6x \
	ti-biosutils \
	ti-edma3lld \

TI_CODEC_ENGINE_INSTALL_STAGING_DIR=$(STAGING_DIR)/ti/codec-engine-$(TI_CODEC_ENGINE_VERSION)
TI_CODEC_ENGINE_INSTALL_TARGET_DIR=$(TARGET_DIR)/usr/lib/ti-codec-engine

TI_CODEC_ENGINE_PLATFORM=UNDEFINED
TI_CODEC_ENGINE_DSP="UNDEFINED"
TI_CODEC_ENGINE_GPPOS="LINUX_GCC"
ifeq ($(BR2_PACKAGE_TI_PLATFORM_omap3),y)
	TI_CODEC_ENGINE_DEVICE=OMAP3530
	TI_CODEC_ENGINE_PROGRAMS="APP_CLIENT DSP_SERVER"
	TI_CODEC_ENGINE_DSPSUFFIX=x64P
	TI_CODEC_ENGINE_DEPENDENCIES += ti-local-power-manager ti-dsplink
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_dm6446),y)
	TI_CODEC_ENGINE_DEVICE=DM6446
	TI_CODEC_ENGINE_PROGRAMS="APP_CLIENT DSP_SERVER"
	TI_CODEC_ENGINE_DSPSUFFIX=x64P
	TI_CODEC_ENGINE_DEPENDENCIES += ti-local-power-manager  ti-dsplink
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_dm6467),y)
	TI_CODEC_ENGINE_DEVICE=DM6467
	TI_CODEC_ENGINE_PROGRAMS="APP_CLIENT DSP_SERVER"
	TI_CODEC_ENGINE_DSPSUFFIX=x64P
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_dm355),y)
	TI_CODEC_ENGINE_DEVICE=DM355
	TI_CODEC_ENGINE_PROGRAMS="APP_LOCAL"
	TI_CODEC_ENGINE_DSPSUFFIX=x64P
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_dm365),y)
	TI_CODEC_ENGINE_DEVICE=DM365
	TI_CODEC_ENGINE_PROGRAMS="APP_LOCAL"
	TI_CODEC_ENGINE_DSPSUFFIX=x64P
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_dm368),y)
	#TODO: Verify if DM365 applies to DM368
	TI_CODEC_ENGINE_DEVICE=DM365
	TI_CODEC_ENGINE_PROGRAMS="APP_LOCAL"
	TI_CODEC_ENGINE_DSPSUFFIX=x64P
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_omapl137),y)
	TI_CODEC_ENGINE_DEVICE=OMAPL137
	TI_CODEC_ENGINE_PROGRAMS="APP_CLIENT DSP_SERVER"
	TI_CODEC_ENGINE_DSPSUFFIX=x674
endif
ifeq ($(BR2_PACKAGE_TI_PLATFORM_omapl138),y)
	TI_CODEC_ENGINE_DEVICE=OMAPL138
	TI_CODEC_ENGINE_PROGRAMS="APP_CLIENT DSP_SERVER"
	TI_CODEC_ENGINE_DSPSUFFIX=x674
endif

TI_CODEC_ENGINE_CONFIGURE_MAKE_ARGS =	\
	DEVICES=$(TI_CODEC_ENGINE_DEVICE) \
	GPPOS=$(TI_CODEC_ENGINE_GPPOS) \
	PROGRAMS=$(TI_CODEC_ENGINE_PROGRAMS) \
	CE_INSTALL_DIR="$(TI_CODEC_ENGINE_DIR)" \
	XDC_INSTALL_DIR="$(TI_XDCTOOLS_INSTALL_DIR)" \
	BIOS_INSTALL_DIR="$(TI_DSPBIOS_INSTALL_DIR)" \
	BIOSUTILS_INSTALL_DIR="$(TI_BIOSUTILS_INSTALL_DIR)" \
	DSPLINK_INSTALL_DIR="$(TI_DSPLINK_INSTALL_STAGING_DIR)" \
	XDAIS_INSTALL_DIR="$(TI_XDAIS_INSTALL_DIR)" \
	FC_INSTALL_DIR="$(TI_FRAMEWORK_COMPONENTS_INSTALL_DIR)" \
	CMEM_INSTALL_DIR="$(TI_LINUXUTILS_INSTALL_STAGING_DIR)" \
	LPM_INSTALL_DIR="$(TI_LOCAL_POWER_MANAGER_INSTALL_STAGING_DIR)" \
	EDMA3_LLD_INSTALL_DIR="$(TI_EDMA3LLD_INSTALL_DIR)" \
	CGTOOLS_V5T=$(HOST_DIR)/usr \
	CGTOOLS_C64P="$(TI_CGT6X_INSTALL_DIR)" \
	CGTOOLS_C674="$(TI_CGT6X_INSTALL_DIR)"


ifeq ($(BR2_PACKAGE_TI_CODEC_ENGINE_EXAMPLES),y)
	TI_CODEC_ENGINE_CONFIGURE_CMDS += $(TI_CODEC_ENGINE_EXAMPLE_CONFIGURE_CMDS)
	TI_CODEC_ENGINE_BUILD_CMDS += $(TI_CODEC_ENGINE_EXAMPLE_BUILD_CMDS)
	TI_CODEC_ENGINE_INSTALL_TARGET_CMDS += $(TI_CODEC_ENGINE_EXAMPLE_INSTALL_TARGET_CMDS)
endif

define TI_CODEC_ENGINE_EXAMPLE_CONFIGURE_CMDS
	echo $(notdir $(TARGET_CROSS))
	sed -i  \
    -e s:arm-none-linux-gnueabi-:$(notdir $(TARGET_CROSS)):g \
    $(@D)/examples/xdcpaths.mak
	$(MAKE1) -C $(@D)/examples/ti/sdo/ce/examples/codecs $(TI_CODEC_ENGINE_CONFIGURE_MAKE_ARGS) .make clean
	$(MAKE1) -C $(@D)/examples/ti/sdo/ce/examples/extensions $(TI_CODEC_ENGINE_CONFIGURE_MAKE_ARGS) .make clean
	$(MAKE1) -C $(@D)/examples/ti/sdo/ce/examples/servers $(TI_CODEC_ENGINE_CONFIGURE_MAKE_ARGS) .make clean
	$(MAKE1) -C $(@D)/examples/ti/sdo/ce/examples/apps $(TI_CODEC_ENGINE_CONFIGURE_MAKE_ARGS) .make clean
endef

define TI_CODEC_ENGINE_INSTALL_STAGING_CMDS
	$(INSTALL) -d $(TI_CODEC_ENGINE_INSTALL_STAGING_DIR)
	cp -a $(@D)/* $(TI_CODEC_ENGINE_INSTALL_STAGING_DIR)
	chmod -R +w $(TI_CODEC_ENGINE_INSTALL_STAGING_DIR)
endef



define TI_CODEC_ENGINE_EXAMPLE_BUILD_CMDS

#Fix AR
	find $(@D)/examples -name "*.mak" -exec \
	sed -i  \
    -e s:/arm-none-linux-gnueabi/bin/ar:/bin/$(notdir $(TARGET_CROSS))ar:g \
	{} \;

	$(MAKE1) -C $(@D)/examples/ti/sdo/ce/examples/codecs $(TI_CODEC_ENGINE_CONFIGURE_MAKE_ARGS) all
	$(MAKE1) -C $(@D)/examples/ti/sdo/ce/examples/extensions $(TI_CODEC_ENGINE_CONFIGURE_MAKE_ARGS) all
	$(MAKE1) -C $(@D)/examples/ti/sdo/ce/examples/servers $(TI_CODEC_ENGINE_CONFIGURE_MAKE_ARGS) all
	$(MAKE1) -C $(@D)/examples/ti/sdo/ce/examples/apps $(TI_CODEC_ENGINE_CONFIGURE_MAKE_ARGS) all
endef

define TI_CODEC_ENGINE_EXAMPLE_INSTALL_TARGET_CMDS
	$(INSTALL) -d $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR); \
	if [ -e $(@D)/examples/apps/system_files/$(TI_CODEC_ENGINE_DEVICE)/loadmodules.sh ]; then \
		cp $(@D)/examples/apps/system_files/$(TI_CODEC_ENGINE_DEVICE)/loadmodules.sh $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR); \
	elif [ -e $(@D)/loadmodules.sh ]; then \
		cp $(@D)/loadmodules.sh $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR); \
	fi ;\
	i_find=`find $(@D) -name "*.$(TI_CODEC_ENGINE_DSPSUFFIX)"` ; \
	for i in $$i_find; do \
		i_dir=`dirname $$i | cut -f3 -d /`; \
		echo Installing $$i TO $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR)/ti-codec-engine-examples/servers/$$i_dir ; \
		$(INSTALL) -d $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR)/ti-codec-engine-examples/servers/`dirname $$i | cut -f3 -d /` ; \
		$(INSTALL) $$i $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR)/ti-codec-engine-examples/servers/`dirname $$i | cut -f3 -d /` ; \
	done ; \
	i_find=`find $(@D) -name "*.xv5T"` ; \
	for i in $$i_find; do \
		i_dir=`dirname $$i | cut -f3 -d /`; \
		echo Installing $$i TO $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR)/ti-codec-engine-examples/servers/$$i_dir ; \
	  	$(INSTALL) -d $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR)/ti-codec-engine-examples/servers/`dirname $$i | cut -f3 -d /` ; \
	  	$(INSTALL) $$i $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR)/ti-codec-engine-examples/servers/`dirname $$i | cut -f3 -d /` ; \
	done; \
	i_find=`find $(@D) -name "*.dat"` ; \
	for i in $$i_find; do \
		i_dir=`dirname $$i | cut -f3 -d /`; \
		echo Installing $$i TO $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR)/ti-codec-engine-examples/servers/$$i_dir ; \
	  	$(INSTALL) -d $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR)/ti-codec-engine-examples/servers/`dirname $$i | cut -f3 -d /` ; \
	  	$(INSTALL) $$i $(TI_CODEC_ENGINE_INSTALL_TARGET_DIR)/ti-codec-engine-examples/servers/`dirname $$i | cut -f3 -d /` ; \
	done; \

	#TODO: Clean up this section. It's basically a cut&paste and should be optional all together.
	# For each directory, softlink to the app server, except special cases
	# cd ${D}/${installdir}/ti-codec-engine-examples
	# for i in $(find . -type d | grep -v servers); do
	# 	{
	# 	pwd
	# 	cd ${D}/${installdir}/ti-codec-engine-examples/$i
	# 	if [ $(basename $i) == "audio1_ires" ] ; then 
	# 		ln -s ../servers/audio1_ires/audio1_ires.${DSPSUFFIX}
	# 	elif [ $(basename $i) == "server_api_example" ] ; then
	# 		ln -s ../servers/server_api_example/audio_copy.${DSPSUFFIX}
	#                 elif [ $(basename $i) != "." ] ; then
	# 		ln -s ../servers/all_codecs/all.${DSPSUFFIX}
	# 	else
	# 		echo Skipping $i
	# 	fi
	# 	}
	# done
endef

$(eval $(call GENTARGETS,package/ti,ti-codec-engine))

