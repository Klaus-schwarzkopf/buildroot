################################################################################
#
# ti-xdctools
#
################################################################################
TI_XDCTOOLS_VERSION:=3.20.01.51
TI_XDCTOOLS_FILE_VERSION:=3_20_01_51

TI_XDCTOOLS_SOURCE:=ti-xdctools-$(TI_XDCTOOLS_VERSION).tar.gz
TI_XDCTOOLS_SOURCE_BIN:=xdctools_setuplinux_$(TI_XDCTOOLS_FILE_VERSION).bin
TI_XDCTOOLS_SOURCE_BIN_FOLDER:=xdctools_$(TI_XDCTOOLS_FILE_VERSION)
TI_XDCTOOLS_SITE:=http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/rtsc/$(TI_XDCTOOLS_FILE_VERSION)/exports
TI_XDCTOOLS_DIR:=$(BUILD_DIR)/ti-xdctools-$(TI_XDCTOOLS_VERSION)

TI_XDCTOOLS_INSTALL_TARGET = NO
TI_XDCTOOLS_INSTALL_STAGING = YES

TI_XDCTOOLS_INSTALL_DIR:=$(STAGING_DIR)/ti/xdctools-$(TI_XDCTOOLS_VERSION)



$(DL_DIR)/$(TI_XDCTOOLS_SOURCE):
	$(call DOWNLOAD,$(TI_XDCTOOLS_SITE),$(TI_XDCTOOLS_SOURCE_BIN))
	chmod +x $(DL_DIR)/$(TI_XDCTOOLS_SOURCE_BIN)
	$(DL_DIR)/$(TI_XDCTOOLS_SOURCE_BIN) --S --prefix $(DL_DIR)
	find $(DL_DIR)/$(TI_XDCTOOLS_SOURCE_BIN_FOLDER) -type f -not -readable -exec sudo chmod gou+r {} \;
	find $(DL_DIR)/$(TI_XDCTOOLS_SOURCE_BIN_FOLDER) -type d -not -executable -exec sudo chmod gou+rx {} \;
	(cd $(DL_DIR); \
		tar -czf $(TI_XDCTOOLS_SOURCE) $(TI_XDCTOOLS_SOURCE_BIN_FOLDER)\
	)
	rm -rf $(DL_DIR)/$(TI_XDCTOOLS_SOURCE_BIN_FOLDER)

# It's install to the staging dir simply for consistency.
# Since it's a binary package it really does not need to be compiled or anything else.
define TI_XDCTOOLS_INSTALL_STAGING_CMDS
	mkdir -p $(TI_XDCTOOLS_INSTALL_DIR)
	cp -r $(@D)/* $(TI_XDCTOOLS_INSTALL_DIR)
	chmod -R +w $(TI_XDCTOOLS_INSTALL_DIR)
endef

define TI_XDCTOOLS_UNINSTALL_STAGING_CMDS
	rm -rf $(TI_XDCTOOLS_INSTALL_DIR)
endef

ti-xdctools-source: $(DL_DIR)/$(TI_XDCTOOLS_SOURCE)


$(eval $(call GENTARGETS,package/ti,ti-xdctools))