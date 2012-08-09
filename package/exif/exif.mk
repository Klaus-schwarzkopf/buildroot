#############################################################
#
# exif
#
#############################################################

EXIF_VERSION = 0.6.21
EXIF_SOURCE = exif-$(EXIF_VERSION).tar.bz2
EXIF_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/project/libexif/exif/$(EXIF_VERSION)
EXIF_CONF_ENV =   POPT_CFLAGS=-I$(STAGING_DIR)/include POPT_LIBS="-L$(STAGING_DIR)/lib -lpopt" 
EXIF_DEPENDENCIES = host-pkg-config libexif popt

$(eval $(call AUTOTARGETS))
