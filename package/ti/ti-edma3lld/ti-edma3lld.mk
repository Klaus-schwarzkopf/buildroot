################################################################################
#
# ti-edma3lld
#
################################################################################
TI_EDMA3LLD_VERSION:=01.11.00.03
TI_EDMA3LLD_FILE_VERSION:=01_11_00_03

TI_EDMA3LLD_SOURCE:=ti-edma3lld-$(TI_EDMA3LLD_VERSION).tar.gz
TI_EDMA3LLD_SOURCE_BIN:=EDMA3_LLD_setuplinux_$(TI_EDMA3LLD_FILE_VERSION).bin
TI_EDMA3LLD_SOURCE_BIN_FOLDER:=edma3_lld_$(TI_EDMA3LLD_FILE_VERSION)
TI_EDMA3LLD_SITE:=http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/edma3_lld/edma3-lld-bios5/$(TI_EDMA3LLD_FILE_VERSION)/exports
TI_EDMA3LLD_DIR:=$(BUILD_DIR)/ti-edma3lld-$(TI_EDMA3LLD_VERSION)

TI_EDMA3LLD_INSTALL_TARGET = NO
TI_EDMA3LLD_INSTALL_STAGING = YES

TI_EDMA3LLD_INSTALL_DIR:=$(STAGING_DIR)/ti/edma3lld-$(TI_EDMA3LLD_VERSION)

$(DL_DIR)/$(TI_EDMA3LLD_SOURCE):
	$(call DOWNLOAD,$(TI_EDMA3LLD_SITE),$(TI_EDMA3LLD_SOURCE_BIN))
	chmod +x $(DL_DIR)/$(TI_EDMA3LLD_SOURCE_BIN)
	$(DL_DIR)/$(TI_EDMA3LLD_SOURCE_BIN) --mode silent --prefix $(DL_DIR)/$(TI_EDMA3LLD_SOURCE_BIN_FOLDER)
	find $(DL_DIR)/$(TI_EDMA3LLD_SOURCE_BIN_FOLDER) -type f -not -readable -exec sudo chmod gou+r {} \;
	find $(DL_DIR)/$(TI_EDMA3LLD_SOURCE_BIN_FOLDER) -type d -not -executable -exec sudo chmod gou+rx {} \;
	(cd $(DL_DIR); \
		tar -czf $(TI_EDMA3LLD_SOURCE) $(TI_EDMA3LLD_SOURCE_BIN_FOLDER)\
	)
	rm -rf $(DL_DIR)/$(TI_EDMA3LLD_SOURCE_BIN_FOLDER)

define TI_EDMA3LLD_INSTALL_STAGING_CMDS
	mkdir -p $(TI_EDMA3LLD_INSTALL_DIR)
	cp -r $(TI_EDMA3LLD_DIR)/* $(TI_EDMA3LLD_INSTALL_DIR)
	chmod -R +w $(TI_EDMA3LLD_INSTALL_DIR)
endef

define TI_EDMA3LLD_UNINSTALL_STAGING_CMDS
	rm -rf $(TI_EDMA3LLD_INSTALL_DIR)
endef

ti-edma3lld-source: $(DL_DIR)/$(TI_EDMA3LLD_SOURCE)


$(eval $(call GENTARGETS,package/ti,ti-edma3lld))