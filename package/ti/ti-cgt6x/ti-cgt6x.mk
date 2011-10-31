################################################################################
#
# ti-cgt6x
#
################################################################################
TI_CGT6X_VERSION:=6.1.12

TI_CGT6X_SOURCE:=ti-cgt6x-$(TI_CGT6X_VERSION).tar.gz
TI_CGT6X_SOURCE_BIN:=ti_cgt_c6000_$(TI_CGT6X_VERSION)_setup_linux_x86.bin
TI_CGT6X_SOURCE_BIN_FOLDER:=c6000cgt$(TI_CGT6X_VERSION)
TI_CGT6X_SITE:=http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/dvsdk/DVSDK_3_00/latest//exports
TI_CGT6X_DIR:=$(BUILD_DIR)/ti-cgt6x-$(TI_CGT6X_VERSION)

TI_CGT6X_INSTALL_TARGET = NO
TI_CGT6X_INSTALL_STAGING = YES

TI_CGT6X_INSTALL_DIR:=$(STAGING_DIR)/ti/cgt6x-$(TI_CGT6X_VERSION)

$(DL_DIR)/$(TI_CGT6X_SOURCE):
	$(call DOWNLOAD,$(TI_CGT6X_SITE),$(TI_CGT6X_SOURCE_BIN))
	chmod +x $(DL_DIR)/$(TI_CGT6X_SOURCE_BIN)
	$(DL_DIR)/$(TI_CGT6X_SOURCE_BIN) --mode silent --nodoc --prefix $(DL_DIR)/$(TI_CGT6X_SOURCE_BIN_FOLDER)
	find $(DL_DIR)/$(TI_CGT6X_SOURCE_BIN_FOLDER) -type f -not -readable -exec sudo chmod gou+r {} \;
	find $(DL_DIR)/$(TI_CGT6X_SOURCE_BIN_FOLDER) -type d -not -executable -exec sudo chmod gou+rx {} \;
	(cd $(DL_DIR); \
		tar -czf $(TI_CGT6X_SOURCE) $(TI_CGT6X_SOURCE_BIN_FOLDER)\
	)
	rm -rf $(DL_DIR)/$(TI_CGT6X_SOURCE_BIN_FOLDER)

define TI_CGT6X_INSTALL_STAGING_CMDS
	mkdir -p $(TI_CGT6X_INSTALL_DIR)
	cp -r $(@D)/* $(TI_CGT6X_INSTALL_DIR)
 	chmod -R +w $(TI_CGT6X_INSTALL_DIR)
endef

define TI_CGT6X_UNINSTALL_STAGING_CMDS
	rm -rf $(TI_CGT6X_INSTALL_DIR)
endef

ti-cgt6x-source: $(DL_DIR)/$(TI_CGT6X_SOURCE)

$(eval $(call GENTARGETS,package/ti,ti-cgt6x))