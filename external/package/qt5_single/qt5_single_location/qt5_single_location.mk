################################################################################
#
# qt5location
#
################################################################################

# QT5_SINGLE_LOCATION_VERSION = 861e372b6ad81570d4f496e42fb25a6699b72f2f
# QT5_SINGLE_LOCATION_SITE = $(QT5_SINGLE__SITE)/qtlocation
# QT5_SINGLE_LOCATION_SITE_METHOD = git
# QT5_SINGLE_LOCATION_GIT_SUBMODULES = YES
# QT5_SINGLE_LOCATION_INSTALL_STAGING = YES
# QT5_SINGLE_LOCATION_SYNC_QT_HEADERS = YES
# 
# QT5_SINGLE_LOCATION_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
# QT5_SINGLE_LOCATION_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL
# 
# ifeq ($(BR2_PACKAGE_QT5_SINGLE_DECLARATIVE),y)
# QT5_SINGLE_LOCATION_DEPENDENCIES += qt5_single_declarative
# endif
# 
# $(eval $(qmake-custom-package))
