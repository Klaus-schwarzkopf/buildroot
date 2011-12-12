#############################################################
#
# dejavu fonts
#
#############################################################

#VIDEOSTREAM_VERSION = 2.33
#VIDEOSTREAM_SOURCE = videostream
VIDEOSTREAM_SITE = /home/klaus/development/handpyrometer/videostream
VIDEOSTREAM_SITE_METHOD = local

VIDEOSTREAM_BUILD_CMDS = \
	$(MAKE) -f $(@D)/Debug/makefile -C $(@D)/Debug 



define VIDEOSTREAM_INSTALL_TARGET_CMDS
#copy font
	mkdir -p $(TARGET_DIR)/usr/lib/fonts
	cp -a $(@D)/ttf/DejaVuSans-Bold.ttf $(TARGET_DIR)/usr/lib/fonts/Default.ttf
#copy pictures
	mkdir -p $(TARGET_DIR)/usr/share/icons/videostream/
	cp -a $(@D)/icons/own/*.png $(TARGET_DIR)/usr/share/icons/videostream/
	cp -a $(@D)/icons/tango/22x22/devices/{camera-photo,camera-video,video-display}.png $(TARGET_DIR)/usr/share/icons/videostream/
	cp -a $(@D)/icons/tango/22x22/categories/preferences-system.png $(TARGET_DIR)/usr/share/icons/videostream/
	cp -a $(@D)/icons/tango/16x16/actions/go-last.png $(TARGET_DIR)/usr/share/icons/videostream/
#copy program
	cp -a $(@D)/Debug/videostream $(TARGET_DIR)/usr/bin/

#copy load modules
	cp -a $(@D)/files/loadmodules_dm365.sh $(TARGET_DIR)/usr/bin/

#copy translations
	mkdir -p $(TARGET_DIR)/usr/share/locale/{de,en,ru}/LC_MESSAGES/
	- cp -R $(@D)/po/de/videostream.mo $(TARGET_DIR)/usr/share/locale/de/LC_MESSAGES/
	- cp -R $(@D)/po/en/videostream.mo $(TARGET_DIR)/usr/share/locale/en/LC_MESSAGES/
	- cp -R $(@D)/po/ru/videostream.mo $(TARGET_DIR)/usr/share/locale/ru/LC_MESSAGES/
#ifeq ($(BR2_PACKAGE_VIDEOSTREAM_DEBUG),y)
#copy files for testing (delete for release)
#	cp $(@D)/files/raw.yuv $(TARGET_DIR)
	cp $(@D)/files/data.img $(TARGET_DIR)
#else
#copy start script
#	cp -R $(@D)/files/S60videostream $(TARGET_DIR)/etc/init.d/
#endif
endef



$(eval $(call GENTARGETS))
