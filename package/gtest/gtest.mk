#############################################################
#
# gtest
#
#############################################################

GTEST_VERSION = 1.6.0
GTEST_SOURCE = gtest-$(GTEST_VERSION).zip
GTEST_SITE = http://googletest.googlecode.com/files

define GTEST_INSTALL_TARGET_CMDS
	cp -a $(@D)/*.a $(TARGET_DIR)/usr/lib/
endef

$(eval $(call CMAKETARGETS))
