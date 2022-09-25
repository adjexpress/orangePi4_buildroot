################################################################################
#
# qt5multimedia
#
################################################################################

# QT5_SINGLE_MULTIMEDIA_VERSION = bd29c87027637a013f2c5e3b549fcda84e4d7545
# QT5_SINGLE_MULTIMEDIA_SITE = $(QT5_SINGLE__SITE)/qtmultimedia/-/archive/$(QT5_SINGLE_MULTIMEDIA_VERSION)
# QT5_SINGLE_MULTIMEDIA_SOURCE = qtmultimedia-$(QT5_SINGLE_MULTIMEDIA_VERSION).tar.bz2
# QT5_SINGLE_MULTIMEDIA_INSTALL_STAGING = YES
# QT5_SINGLE_MULTIMEDIA_SYNC_QT_HEADERS = YES
# 
# QT5_SINGLE_MULTIMEDIA_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
# QT5_SINGLE_MULTIMEDIA_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPL3 LICENSE.FDL

# ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BASE),y)
# QT5_SINGLE_DEPENDENCIES += gst1-plugins-base
# endif
# 
# # ifeq ($(BR2_PACKAGE_QT5_SINGLE_DECLARATIVE),y)
# # QT5_SINGLE_MULTIMEDIA_DEPENDENCIES += qt5_single_declarative
# # endif
# 
# ifeq ($(BR2_PACKAGE_LIBGLIB2)$(BR2_PACKAGE_PULSEAUDIO),yy)
# QT5_SINGLE_DEPENDENCIES += libglib2 pulseaudio
# endif
# 
# ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
# QT5_SINGLE_DEPENDENCIES += alsa-lib
# endif

# ifeq ($(BR2_PACKAGE_QT5_SINGLE_BASE_EXAMPLES),y)
# QT5_SINGLE_MULTIMEDIA_LICENSE += , LGPL-2.1+ (examples/multimedia/spectrum/3rdparty/fftreal)
# QT5_SINGLE_MULTIMEDIA_LICENSE_FILES += examples/multimedia/spectrum/3rdparty/fftreal/license.txt
# endif
# 
# $(eval $(qmake-custom-package))
