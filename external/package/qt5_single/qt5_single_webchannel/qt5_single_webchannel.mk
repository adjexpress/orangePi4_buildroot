################################################################################
#
# qt5webchannel
#
################################################################################

# QT5_SINGLE_WEBCHANNEL_VERSION = fa8b07105b5e274daaa8adcc129fa4aa0447f9f7
# QT5_SINGLE_WEBCHANNEL_SITE = $(QT5_SINGLE__SITE)/qtwebchannel/-/archive/$(QT5_SINGLE_WEBCHANNEL_VERSION)
# QT5_SINGLE_WEBCHANNEL_SOURCE = qtwebchannel-$(QT5_SINGLE_WEBCHANNEL_VERSION).tar.bz2
# QT5_SINGLE_WEBCHANNEL_DEPENDENCIES = qt5websockets
# QT5_SINGLE_WEBCHANNEL_INSTALL_STAGING = YES
# QT5_SINGLE_WEBCHANNEL_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
# QT5_SINGLE_WEBCHANNEL_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL
# QT5_SINGLE_WEBCHANNEL_SYNC_QT_HEADERS = YES
# 
# ifeq ($(BR2_PACKAGE_QT5_SINGLE_BASE_EXAMPLES),y)
# QT5_SINGLE_WEBCHANNEL_LICENSE += , BSD-3-Clause (examples)
# endif
# 
# ifeq ($(BR2_PACKAGE_QT5_SINGLE_DECLARATIVE),y)
# QT5_SINGLE_WEBCHANNEL_DEPENDENCIES += qt5_single_declarative
# endif
# 
# define QT5_SINGLE_WEBCHANNEL_INSTALL_TARGET_JAVASCRIPT
# 	$(INSTALL) -m 0644 -D $(@D)/examples/webchannel/shared/qwebchannel.js \
# 		$(TARGET_DIR)/var/www/qwebchannel.js
# endef
# QT5_SINGLE_WEBCHANNEL_POST_INSTALL_TARGET_HOOKS += QT5_SINGLE_WEBCHANNEL_INSTALL_TARGET_JAVASCRIPT
# 
# $(eval $(qmake-custom-package))
