#############################################################
#
# videostream
#
#############################################################

VIDEOSTREAM_VERSION = 1.00
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
	-cp -a $(@D)/Debug/videostream $(TARGET_DIR)/usr/bin/

#copy load modules
	cp -a $(@D)/files/loadmodules_dm365.sh $(TARGET_DIR)/usr/bin/

#copy translations
	mkdir -p $(TARGET_DIR)/usr/lib/locale/

	    for lang in en_GB.utf8 fr_FR.utf8 ru_RU.utf8 de_DE.utf8 es_ES.utf8; do \
		cp -R $(HOST_DIR)/opt/ext-toolchain/arm-none-linux-gnueabi/libc/usr/lib/locale/$$lang ${TARGET_DIR}/usr/lib/locale/ ; \
	    done

	    - for lang in en fr ru de es; do \
		mkdir -p $(TARGET_DIR)/usr/share/locale/$$lang/LC_MESSAGES/ ; \
		cp -R $(@D)/po/$$lang/videostream.mo $(TARGET_DIR)/usr/share/locale/$$lang/LC_MESSAGES/ ; \
	    done



#ifeq ($(BR2_PACKAGE_VIDEOSTREAM_DEBUG),y)
#copy files for testing (delete for release)
#	cp $(@D)/files/raw.yuv $(TARGET_DIR)
#	cp $(@D)/files/data.img $(TARGET_DIR)
#else
#copy start script
#	cp -R $(@D)/files/S60videostream $(TARGET_DIR)/etc/init.d/
#endif

#mono /home/klaus/LeopardBoardDM365sdkEVAL2011Q2/bootloader/u-boot-2010.12-rc2-psp03.01.01.39/ti-flash-utils/src/DM36x/GNU/bc_DM36x.exe -uboot -pageSize 2048 -blockNum 25 -startAddr 0x82000000 -loadAddr 0x82000000 $(TARGET_DIR)/../images/u-boot.bin -o $(TARGET_DIR)/../images/u-boot.nand.bin
endef


i18n:
	mkdir -p $(TARGET_DIR)/usr/share/locale/{de,en,ru,fr,es}/LC_MESSAGES/
	- cp -R $(@D)/po/de/videostream.mo $(TARGET_DIR)/usr/share/locale/de/LC_MESSAGES/
	- cp -R $(@D)/po/en/videostream.mo $(TARGET_DIR)/usr/share/locale/en/LC_MESSAGES/
	- cp -R $(@D)/po/ru/videostream.mo $(TARGET_DIR)/usr/share/locale/ru/LC_MESSAGES/
	- cp -R $(@D)/po/fr/videostream.mo $(TARGET_DIR)/usr/share/locale/fr/LC_MESSAGES/
	- cp -R $(@D)/po/fr/videostream.mo $(TARGET_DIR)/usr/share/locale/es/LC_MESSAGES/
	cp -R $(HOST_DIR)/opt/ext-toolchain/arm-none-linux-gnueabi/libc/usr/lib/locale/en_GB.utf8 ${TARGET_DIR}/usr/lib/locale/
	cp -R $(HOST_DIR)/opt/ext-toolchain/arm-none-linux-gnueabi/libc/usr/lib/locale/fr_FR.utf8 ${TARGET_DIR}/usr/lib/locale/
	cp -R $(HOST_DIR)/opt/ext-toolchain/arm-none-linux-gnueabi/libc/usr/lib/locale/ru_RU.utf8 ${TARGET_DIR}/usr/lib/locale/
	cp -R $(HOST_DIR)/opt/ext-toolchain/arm-none-linux-gnueabi/libc/usr/lib/locale/de_DE.utf8 ${TARGET_DIR}/usr/lib/locale/
	cp -R $(HOST_DIR)/opt/ext-toolchain/arm-none-linux-gnueabi/libc/usr/lib/locale/es_ES.utf8 ${TARGET_DIR}/usr/lib/locale/

$(eval $(call GENTARGETS))
