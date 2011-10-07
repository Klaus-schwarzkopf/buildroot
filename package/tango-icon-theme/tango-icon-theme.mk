#############################################################
#
# tango-icon-theme
#
#############################################################
TANGO_ICON_THEME_VERSION = 0.8.90
TANGO_ICON_THEME_SOURCE = tango-icon-theme-$(TANGO_ICON_THEME_VERSION).tar.gz
TANGO_ICON_THEME_SITE = http://tango.freedesktop.org/releases/

TANGO_ICON_THEME_CONF_ENV = PKG_CONFIG_PATH=$(HOST_DIR)/usr/lib/pkgconfig
TANGO_ICON_THEME_CONF_OPT = --disable-icon-framing

TANGO_ICON_THEME_DEPENDENCIES = host-icon-naming-utils host-pkg-config

$(eval $(call AUTOTARGETS))
