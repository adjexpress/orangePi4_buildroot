################################################################################
#
# qt5virtualkeyboard
#
################################################################################

# QT5_SINGLE_VIRTUALKEYBOARD_VERSION = 98d1fd864cbb6c7c012c4139118808af110fb8f0
# QT5_SINGLE_VIRTUALKEYBOARD_SITE = $(QT5_SINGLE__SITE)/qtvirtualkeyboard/-/archive/$(QT5_SINGLE_VIRTUALKEYBOARD_VERSION)
# QT5_SINGLE_VIRTUALKEYBOARD_SOURCE = qtvirtualkeyboard-$(QT5_SINGLE_VIRTUALKEYBOARD_VERSION).tar.bz2
# QT5_SINGLE_VIRTUALKEYBOARD_DEPENDENCIES = qt5_single_declarative qt5_single_svg
# QT5_SINGLE_VIRTUALKEYBOARD_INSTALL_STAGING = YES
# QT5_SINGLE_VIRTUALKEYBOARD_SYNC_QT_HEADERS = YES
# 
# QT5_SINGLE_VIRTUALKEYBOARD_LICENSE = GPL-3.0
# QT5_SINGLE_VIRTUALKEYBOARD_LICENSE_FILES = LICENSE.GPL3

# QT5_SINGLE_VIRTUALKEYBOARD_LANGUAGE_LAYOUTS = $(call qstrip,$(BR2_PACKAGE_QT5_SINGLE_VIRTUALKEYBOARD_LANGUAGE_LAYOUTS))
# ifneq ($(strip $(QT5_SINGLE_VIRTUALKEYBOARD_LANGUAGE_LAYOUTS)),)
# QT5_SINGLE_VIRTUALKEYBOARD_QMAKEFLAGS += CONFIG+="$(foreach lang,$(QT5_SINGLE_VIRTUALKEYBOARD_LANGUAGE_LAYOUTS),lang-$(lang))"
# 
# ifneq ($(filter ja_JP all,$(QT5_SINGLE_VIRTUALKEYBOARD_LANGUAGE_LAYOUTS)),)
# QT5_SINGLE_VIRTUALKEYBOARD_LICENSE += , Apache-2.0 (openwnn)
# QT5_SINGLE_VIRTUALKEYBOARD_LICENSE_FILES += src/plugins/openwnn/3rdparty/openwnn/NOTICE
# endif
# 
# ifneq ($(filter zh_CN all,$(QT5_SINGLE_VIRTUALKEYBOARD_LANGUAGE_LAYOUTS)),)
# QT5_SINGLE_VIRTUALKEYBOARD_LICENSE += , Apache-2.0 (pinyin)
# QT5_SINGLE_VIRTUALKEYBOARD_LICENSE_FILES += src/plugins/pinyin/3rdparty/pinyin/NOTICE
# endif
# 
# ifneq ($(filter zh_TW all,$(QT5_SINGLE_VIRTUALKEYBOARD_LANGUAGE_LAYOUTS)),)
# QT5_SINGLE_VIRTUALKEYBOARD_LICENSE += , Apache-2.0 (tcime), BSD-3-Clause (tcime)
# QT5_SINGLE_VIRTUALKEYBOARD_LICENSE_FILES += src/plugins/tcime/3rdparty/tcime/COPYING
# endif
# endif
# 
# ifeq ($(BR2_PACKAGE_QT5_SINGLE_VIRTUALKEYBOARD_HANDWRITING),y)
# QT5_SINGLE_VIRTUALKEYBOARD_CONF_OPTS += CONFIG+=handwriting
# QT5_SINGLE_VIRTUALKEYBOARD_LICENSE += , MIT (lipi-toolkit)
# QT5_SINGLE_VIRTUALKEYBOARD_LICENSE_FILES += src/plugins/lipi-toolkit/3rdparty/lipi-toolkit/MIT_LICENSE.txt
# endif
# 
# ifeq ($(BR2_PACKAGE_QT5_SINGLE_VIRTUALKEYBOARD_ARROW_KEY_NAVIGATION),y)
# QT5_SINGLE_VIRTUALKEYBOARD_CONF_OPTS += CONFIG+=arrow-key-navigation
# endif
# 
# $(eval $(qmake-custom-package))
