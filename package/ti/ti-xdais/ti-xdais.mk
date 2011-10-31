################################################################################
#
# ti-xdais
#
################################################################################
TI_XDAIS_VERSION:=6.25.02.11
TI_XDAIS_FILE_VERSION:=6_25_02_11
TI_XDAIS_SOURCE:=xdais_$(TI_XDAIS_FILE_VERSION).tar.gz
TI_XDAIS_SITE:=http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/xdais/$(TI_XDAIS_FILE_VERSION)/exports
TI_XDAIS_DIR:=$(BUILD_DIR)/ti-xdais-$(TI_XDAIS_VERSION)

TI_XDAIS_INSTALL_TARGET = NO
TI_XDAIS_INSTALL_STAGING = YES

TI_XDAIS_INSTALL_DIR:=$(STAGING_DIR)/ti/xdai-$(TI_XDAIS_VERSION)


$(DL_DIR)/$(TI_XDAIS_SOURCE):
	$(call DOWNLOAD,$(TI_XDAIS_SITE),$(TI_XDAIS_SOURCE_BIN))

define TI_XDAIS_INSTALL_STAGING_CMDS
	mkdir -p $(TI_XDAIS_INSTALL_DIR)
	cp -r $(@D)/* $(TI_XDAIS_INSTALL_DIR)
	chmod -R +w $(TI_XDAIS_INSTALL_DIR)
endef

define TI_XDAIS_UNINSTALL_STAGING_CMDS
	rm -rf $(TI_XDAIS_INSTALL_DIR)
endef


ti-xdais-source: $(DL_DIR)/$(TI_XDAIS_SOURCE)

$(eval $(call GENTARGETS,package/ti,ti-xdais))