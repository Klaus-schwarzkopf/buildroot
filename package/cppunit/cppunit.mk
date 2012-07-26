#############################################################
#
# cppunit
#
#############################################################

CPPUNIT_VERSION = 1.12.1
CPPUNIT_SOURCE = cppunit-$(CPPUNIT_VERSION).tar.gz
CPPUNIT_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/sourceforge/cppunit

$(eval $(call AUTOTARGETS))
