################################################################################
#
# ti-dspbios
#
################################################################################
TI_DSPBIOS_VERSION:=5.41.04.18
TI_DSPBIOS_FILE_VERSION:=5_41_04_18

TI_DSPBIOS_SOURCE:=ti-bios-$(TI_DSPBIOS_VERSION).tar.gz
TI_DSPBIOS_SOURCE_BIN:=bios_setuplinux_$(TI_DSPBIOS_FILE_VERSION).bin
TI_DSPBIOS_SOURCE_BIN_FOLDER:=bios_$(TI_DSPBIOS_FILE_VERSION)
TI_DSPBIOS_SITE:=http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/bios/dspbios/$(TI_DSPBIOS_FILE_VERSION)/exports

TI_DSPBIOS_DIR:=$(BUILD_DIR)/ti-dspbios-$(TI_DSPBIOS_VERSION)

TI_DSPBIOS_INSTALL_TARGET = NO
TI_DSPBIOS_INSTALL_STAGING = YES

TI_DSPBIOS_INSTALL_DIR:=$(STAGING_DIR)/ti/dspbios-$(TI_DSPBIOS_VERSION)


$(DL_DIR)/$(TI_DSPBIOS_SOURCE):
	$(call DOWNLOAD,$(TI_DSPBIOS_SITE),$(TI_DSPBIOS_SOURCE_BIN))
	chmod +x $(DL_DIR)/$(TI_DSPBIOS_SOURCE_BIN)
	$(DL_DIR)/$(TI_DSPBIOS_SOURCE_BIN) --S --prefix $(DL_DIR)
	find $(DL_DIR)/$(TI_DSPBIOS_SOURCE_BIN_FOLDER) -type f -not -readable -exec sudo chmod gou+r {} \;
	find $(DL_DIR)/$(TI_DSPBIOS_SOURCE_BIN_FOLDER) -type d -not -executable -exec sudo chmod gou+rx {} \;
	(cd $(DL_DIR); \
		tar -czf $(TI_DSPBIOS_SOURCE) $(TI_DSPBIOS_SOURCE_BIN_FOLDER)\
	)
	rm -rf $(DL_DIR)/$(TI_DSPBIOS_SOURCE_BIN_FOLDER)

define TI_DSPBIOS_INSTALL_STAGING_CMDS
	mkdir -p $(TI_DSPBIOS_INSTALL_DIR)
	cp -r $(TI_DSPBIOS_DIR)/* $(TI_DSPBIOS_INSTALL_DIR)
	chmod -R +w $(TI_DSPBIOS_INSTALL_DIR)	
endef

define TI_DSPBIOS_UNINSTALL_STAGING_CMDS
	rm -rf $(TI_DSPBIOS_INSTALL_DIR)
endef


ti-dspbios-source: $(DL_DIR)/$(TI_DSPBIOS_SOURCE)

$(eval $(call GENTARGETS,package/ti,ti-dspbios))