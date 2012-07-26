#############################################################
#
# cunit
#
#############################################################

CUNIT_VERSION = 2.1-2
CUNIT_SOURCE = CUnit-$(CUNIT_VERSION)-src.tar.bz2
CUNIT_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/cunit

$(eval $(call AUTOTARGETS))
