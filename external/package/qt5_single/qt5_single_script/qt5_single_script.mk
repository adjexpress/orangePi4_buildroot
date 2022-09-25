################################################################################
#
# qt5script
#
################################################################################

# QT5_SINGLE_SCRIPT_VERSION = 5be95f966aabc5170f0aacfd4b0a46217241bfd6
# QT5_SINGLE_SCRIPT_SITE = $(QT5_SINGLE__SITE)/qtscript/-/archive/$(QT5_SINGLE_SCRIPT_VERSION)
# QT5_SINGLE_SCRIPT_SOURCE = qtscript-$(QT5_SINGLE_SCRIPT_VERSION).tar.bz2
# QT5_SINGLE_SCRIPT_INSTALL_STAGING = YES
# QT5_SINGLE_SCRIPT_SYNC_QT_HEADERS = YES
# 
# # JavaScriptCore contains files under BSD-2-Clause, BSD-3-Clause, and LGPL-2+.
# # This is linked into libQt5Script, which also contains Qt sources under
# # LGPL-2.1 (only). Therefore, the library is  LGPL-2.1 and BSD-3-Clause.
# # libQt5ScriptTools is under the normal Qt opensource license.
# QT5_SINGLE_SCRIPT_LICENSE = LGPL-2.1, BSD-3-Clause, LGPL-3.0 or GPL-2.0+ (libQt5ScriptTools), GFDL-1.3 (docs)
# # LGPL-2.1 license file is missing
# QT5_SINGLE_SCRIPT_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.LGPL3 LICENSE.FDL
# # License files from JavaScriptCore
# QT5_SINGLE_SCRIPT_LICENSE_FILES += \
# 	src/3rdparty/javascriptcore/JavaScriptCore/COPYING.LIB \
# 	src/3rdparty/javascriptcore/JavaScriptCore/pcre/COPYING
# 
# $(eval $(qmake-custom-package))
