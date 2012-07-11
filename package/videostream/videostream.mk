#############################################################
#
# videostream
#
#############################################################

VIDEOSTREAM_VERSION = 1.00
#VIDEOSTREAM_SOURCE = videostream
VIDEOSTREAM_SITE = /home/klaus/development/handpyrometer/videostream
VIDEOSTREAM_SITE_METHOD = local
VIDEOSTREAM_DEPENDENCIES = directfb linux
VIDEOSTREAM_AUTORECONF=YES


VIDEOSTREAM_CONF_ENV = CFLAGS="${CFLAGS} -I$(@D)/../linux-custom/include"

$(eval $(call AUTOTARGETS))

#$(eval $(call GENTARGETS))
