################################################################################
#
# qt5xmlpatterns
#
################################################################################

# QT5_SINGLE_XMLPATTERNS_VERSION = 189e28d0aff1f3d7960228ba318b83e3cadac98c
# QT5_SINGLE_XMLPATTERNS_SITE = $(QT5_SINGLE__SITE)/qtxmlpatterns/-/archive/$(QT5_SINGLE_XMLPATTERNS_VERSION)
# QT5_SINGLE_XMLPATTERNS_SOURCE = qtxmlpatterns-$(QT5_SINGLE_XMLPATTERNS_VERSION).tar.bz2
# QT5_SINGLE_XMLPATTERNS_INSTALL_STAGING = YES
# QT5_SINGLE_XMLPATTERNS_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
# QT5_SINGLE_XMLPATTERNS_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL
# QT5_SINGLE_XMLPATTERNS_SYNC_QT_HEADERS = YES
# 
# ifeq ($(BR2_PACKAGE_QT5_SINGLE_DECLARATIVE),y)
# QT5_SINGLE_XMLPATTERNS_DEPENDENCIES += qt5_single_declarative
# endif
# 
# ifeq ($(BR2_PACKAGE_QT5_SINGLE_BASE_EXAMPLES),y)
# QT5_SINGLE_XMLPATTERNS_LICENSE += , BSD-3-Clause (examples)
# endif
# 
# $(eval $(qmake-custom-package))
