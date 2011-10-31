################################################################################
#
# ti-biosutils
#
################################################################################
TI_BIOSUTILS_VERSION:=1.02.02.02
TI_BIOSUTILS_FILE_VERSION_MAJOR:=1_02_02
TI_BIOSUTILS_FILE_VERSION:=$(TI_BIOSUTILS_FILE_VERSION_MAJOR)_02
TI_BIOSUTILS_SOURCE:=biosutils_$(TI_BIOSUTILS_FILE_VERSION_MAJOR).tar.gz
TI_BIOSUTILS_SITE:=http://software-dl.ti.com/dsps/dsps_public_sw/sdo_sb/targetcontent/Bios_Utils/$(TI_BIOSUTILS_FILE_VERSION)/exports
TI_BIOSUTILS_DIR:=$(BUILD_DIR)/ti-biosutils-$(TI_BIOSUTILS_VERSION)

TI_BIOSUTILS_INSTALL_TARGET = NO
TI_BIOSUTILS_INSTALL_STAGING = YES

TI_BIOSUTILS_INSTALL_DIR:=$(STAGING_DIR)/ti/biosutils-$(TI_BIOSUTILS_VERSION)

define TI_BIOSUTILS_INSTALL_STAGING_CMDS
	mkdir -p $(TI_BIOSUTILS_INSTALL_DIR)
	cp -r $(TI_BIOSUTILS_DIR)/* $(TI_BIOSUTILS_INSTALL_DIR)
	chmod -R +w $(TI_BIOSUTILS_INSTALL_DIR)
endef

define TI_BIOSUTILS_UNINSTALL_STAGING_CMDS
	rm -rf $(TI_BIOSUTILS_INSTALL_DIR)
endef

$(eval $(call GENTARGETS,package/ti,ti-biosutils))