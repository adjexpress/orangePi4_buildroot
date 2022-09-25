################################################################################
#
# qt5_single_connectivity
#
################################################################################

# QT5_SINGLE_CONNECTIVITY_VERSION = 5e9ca5d36d65dadb98ef90013a1dcf15fbd7ae26
# QT5_SINGLE_CONNECTIVITY_SITE = $(QT5_SINGLE__SITE)/qtconnectivity/-/archive/$(QT5_SINGLE_CONNECTIVITY_VERSION)
# QT5_SINGLE_CONNECTIVITY_SOURCE = qtconnectivity-$(QT5_SINGLE_CONNECTIVITY_VERSION).tar.bz2
# QT5_SINGLE_CONNECTIVITY_INSTALL_STAGING = YES
# QT5_SINGLE_CONNECTIVITY_SYNC_QT_HEADERS = YES
# 
# QT5_SINGLE_CONNECTIVITY_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
# QT5_SINGLE_CONNECTIVITY_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL
# 
# ifeq ($(BR2_PACKAGE_QT5_SINGLE_BASE_EXAMPLES),y)
# QT5_SINGLE_CONNECTIVITY_LICENSE += , BSD-3-Clause (examples)
# endif

# QT5_SINGLE_DEPENDENCIES += $(if $(BR2_PACKAGE_QT5_SINGLE_DECLARATIVE),qt5_single_declarative)
# QT5_SINGLE_DEPENDENCIES += $(if $(BR2_PACKAGE_BLUEZ5_UTILS),bluez5_utils)
# QT5_SINGLE_DEPENDENCIES += $(if $(BR2_PACKAGE_NEARD),neard)

# $(eval $(qmake-custom-package))
