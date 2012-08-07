#############################################################
#
# videostream
#
#############################################################

VIDEOSTREAM_VERSION = 1.00
VIDEOSTREAM_SITE = /home/klaus/development/handpyrometer/videostream
VIDEOSTREAM_SITE_METHOD = local
VIDEOSTREAM_DEPENDENCIES = directfb linux
VIDEOSTREAM_AUTORECONF=YES

VIDEOSTREAM_CONF_ENV = CFLAGS="${CFLAGS} -I$(@D)/../linux-custom/include -I$(@D)/../linux-2.6.32/include"


define VIDEOSTREAM_INSTALL_TARGET_CMDS
#install program
	cp -a $(@D)/src/videostream $(TARGET_DIR)/usr/bin/
	chmod +x $(TARGET_DIR)/usr/bin/videostream

#copy font
	mkdir -p $(TARGET_DIR)/usr/lib/fonts
	cp -a $(@D)/ttf/DejaVuSans-Bold.ttf $(TARGET_DIR)/usr/lib/fonts/Default.ttf

#copy pictures
	mkdir -p $(TARGET_DIR)/usr/share/icons/videostream/
	cp -a $(@D)/icons/tango/22x22/devices/{camera-photo,camera-video,video-display}.png $(TARGET_DIR)/usr/share/icons/videostream/
	cp -a $(@D)/icons/tango/22x22/categories/preferences-system.png $(TARGET_DIR)/usr/share/icons/videostream/
	cp -a $(@D)/icons/tango/16x16/actions/go-last.png $(TARGET_DIR)/usr/share/icons/videostream/
	cp -a $(@D)/icons/own/*.png $(TARGET_DIR)/usr/share/icons/videostream/

#copy needed files
	cp -a $(@D)/files/S30videostream $(TARGET_DIR)/etc/init.d/
	chmod +x $(TARGET_DIR)/etc/init.d/S30videostream

	cp -a $(@D)/files/g_acm_ms.sh $(TARGET_DIR)/usr/bin/
	chmod +x $(TARGET_DIR)/usr/bin/g_acm_ms.sh

#copy translations
	mkdir -p $(TARGET_DIR)/usr/lib/locale/

	for lang in en_GB.utf8 fr_FR.utf8 ru_RU.utf8 de_DE.utf8 es_ES.utf8; do \
		cp -R $(HOST_DIR)/opt/ext-toolchain/arm-none-linux-gnueabi/libc/usr/lib/locale/$$lang ${TARGET_DIR}/usr/lib/locale/ ; \
	done

	- for lang in en fr ru de es; do \
		mkdir -p $(TARGET_DIR)/usr/share/locale/$$lang/LC_MESSAGES/ ; \
		cp -R $(@D)/po/$$lang/videostream.mo $(TARGET_DIR)/usr/share/locale/$$lang/LC_MESSAGES/ ; \
	done

endef

$(eval $(call AUTOTARGETS))
