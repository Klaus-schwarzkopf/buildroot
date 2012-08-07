#############################################################
#
# gtest
#
#############################################################

GTEST_VERSION = 1.6.0
GTEST_SOURCE = gtest-$(GTEST_VERSION).zip
GTEST_SITE = http://googletest.googlecode.com/files
GTEST_INSTALL_STAGING = YES

define GTEST_INSTALL_TARGET_CMDS
	cp -a $(@D)/*.a $(TARGET_DIR)/usr/lib/
endef

define GTEST_INSTALL_STAGING_CMDS
	cp -a $(@D)/*.a $(STAGING_DIR)/usr/lib/
	cp -ar $(@D)/include/gtest $(STAGING_DIR)/usr/include/
endef

$(eval $(call CMAKETARGETS))
