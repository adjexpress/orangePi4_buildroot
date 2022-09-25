################################################################################
#
# qt5sensors
#
################################################################################
# 
# QT5_SINGLE_SENSORS_VERSION = 921a31375f29e429e95352b08b2b9dbfea663cb1
# QT5_SINGLE_SENSORS_SITE = $(QT5_SINGLE__SITE)/qtsensors/-/archive/$(QT5_SINGLE_SENSORS_VERSION)
# QT5_SINGLE_SENSORS_SOURCE = qtsensors-$(QT5_SINGLE_SENSORS_VERSION).tar.bz2
# QT5_SINGLE_SENSORS_INSTALL_STAGING = YES
# QT5_SINGLE_SENSORS_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
# QT5_SINGLE_SENSORS_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL
# QT5_SINGLE_SENSORS_SYNC_QT_HEADERS = YES
# 
# ifeq ($(BR2_PACKAGE_QT5_SINGLE_DECLARATIVE),y)
# QT5_SINGLE_SENSORS_DEPENDENCIES += qt5_single_declarative
# endif
# 
# $(eval $(qmake-custom-package))
