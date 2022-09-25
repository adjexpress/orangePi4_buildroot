################################################################################
#
# qt5websockets
#
################################################################################

# QT5_SINGLE_WEBSOCKETS_VERSION = b13b56904b76e96ea52d0efe56395acc94b17d96
# QT5_SINGLE_WEBSOCKETS_SITE = $(QT5_SINGLE__SITE)/qtwebsockets/-/archive/$(QT5_SINGLE_WEBSOCKETS_VERSION)
# QT5_SINGLE_WEBSOCKETS_SOURCE = qtwebsockets-$(QT5_SINGLE_WEBSOCKETS_VERSION).tar.bz2
# QT5_SINGLE_WEBSOCKETS_INSTALL_STAGING = YES
# QT5_SINGLE_WEBSOCKETS_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools)
# QT5_SINGLE_WEBSOCKETS_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3
# QT5_SINGLE_WEBSOCKETS_SYNC_QT_HEADERS = YES
# 
# ifeq ($(BR2_PACKAGE_QT5_SINGLE_BASE_EXAMPLES),y)
# QT5_SINGLE_WEBSOCKETS_LICENSE += , BSD-3-Clause (examples)
# endif
# 
# ifeq ($(BR2_PACKAGE_QT5_SINGLE_DECLARATIVE),y)
# QT5_SINGLE_WEBSOCKETS_DEPENDENCIES += qt5_single_declarative
# endif
# 
# $(eval $(qmake-custom-package))
