#############################################################
#
# dejavu fonts
#
#############################################################

DEJAVU_FONTS_VERSION = 2.33
DEJAVU_FONTS_SOURCE = dejavu-fonts-ttf-$(DEJAVU_FONTS_VERSION).tar.bz2
DEJAVU_FONTS_SITE = http://$(BR2_SOURCEFORGE_MIRROR).dl.sourceforge.net/project/dejavu/dejavu/$(DEJAVU_FONTS_VERSION)/

define DEJAVU_FONTS_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/usr/lib/fonts
	cp -a $(@D)/ttf/*.ttf $(TARGET_DIR)/usr/lib/fonts
endef

$(eval $(call GENTARGETS))
