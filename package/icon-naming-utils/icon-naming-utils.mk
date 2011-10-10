#############################################################
#
# icon-naming-utils
#
#############################################################
ICON_NAMING_UTILS_VERSION = 0.8.90
ICON_NAMING_UTILS_SOURCE = icon-naming-utils-$(ICON_NAMING_UTILS_VERSION).tar.gz
ICON_NAMING_UTILS_SITE = http://tango.freedesktop.org/releases/
HOST_ICON_NAMING_UTILS_CONF_OPT = --datarootdir=$(HOST_DIR)/usr/lib

$(eval $(call AUTOTARGETS,host))
