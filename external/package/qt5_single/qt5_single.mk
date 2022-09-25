################################################################################
#
# qt5
#
################################################################################

# QT5_SINGLE_VERSION_MAJOR = 5.15
# QT5_SINGLE_VERSION = $(QT5_SINGLE_VERSION_MAJOR).4

# QT5_SINGLE_SOURCE_TARBALL_PREFIX = everywhere-src
# QT5_SINGLE_SITE = https://invent.kde.org/qt/qt
# QT5_SINGLE_VERSION = f31e001a9399e4e620847ea2c3e90749350140ae
# QT5_SINGLE_SITE = $(QT5_SINGLE_SITE)/qtbase/-/archive/$(QT5_SINGLE_VERSION)
# QT5_SINGLE_SOURCE = qtbase-$(QT5_SINGLE_VERSION).tar.bz2


# QT5_SINGLE_SITE = $(BR2_EXTERNAL)/package/qt5_single/Src
# QT5_SINGLE_SOURCE = qt-everywhere-opensource-src-5.15.4.tar.xz
# QT5_SINGLE_SITE_METHOD = locale

# QT5_SINGLE_SITE = file://$(BR2_EXTERNAL)/board/orangepi/orangepi-4/src/qt
# QT5_SINGLE_SITE_METHOD = file
QT5_SINGLE_SITE = https://download.qt.io/official_releases/qt/5.15/5.15.4/single/qt-everywhere-opensource-src-5.15.4.tar.xz
QT5_SINGLE_SOURCE = qt-everywhere-opensource-src-5.15.4.tar.xz

QT5_SINGLE_DEPENDENCIES = host-pkgconf pcre2 zlib
QT5_SINGLE_INSTALL_STAGING = YES
QT5_SINGLE_SYNC_QT_HEADERS = YES

# # From commits:
# # 4ce7053a59 "Avoid processing-intensive painting of high number of tiny dashes"
# # e7ea2ed27c "Improve fix for avoiding huge number of tiny dashes"
# QT5_SINGLE_IGNORE_CVES += CVE-2021-38593
# # From commit 2766b2cba6ca4b1c430304df5437e2a6c874b107 "QProcess/Unix: ensure we don't accidentally execute something from CWD"
# QT5_SINGLE_IGNORE_CVES += CVE-2022-25255
# # From commit e68ca8e51375d963b2391715f70b42707992dbd8 "Windows: use QSystemLibrary instead of LoadLibrary directly"
# QT5_SINGLE_IGNORE_CVES += CVE-2022-25634

# A few comments:
#  * -no-pch to workaround the issue described at
#     http://comments.gmane.org/gmane.comp.lib.qt.devel/5933.
#  * -system-zlib because zlib is mandatory for Qt build, and we
#     want to use the Buildroot packaged zlib
#  * -system-pcre because pcre is mandatory to build Qt, and we
#    want to use the one packaged in Buildroot
#  * -no-feature-relocatable to work around path mismatch
#     while searching qml files and buildroot BR2_ROOTFS_MERGED_USR
#     feature enabled
QT5_SINGLE_CONFIGURE_OPTS += \
	-optimized-qmake \
	-no-iconv \
	-system-zlib \
	-system-pcre \
	-no-pch \
	-no-feature-relocatable \
	-no-rpath \
	-static \
	-optimize-size \
	-reduce-exports \
	-no-use-gold-linker \
	-no-compile-examples \
	-skip qtwebengine -skip qtwayland -skip qtwinextras -skip qtx11extras 

# -skip qtx11extras -skip qtwayland -skip qtwinextras -reduce-relocations -no-rpath \

# starting from version 5.9.0, -optimize-debug is enabled by default
# for debug builds and it overrides -O* with -Og which is not what we
# want.
QT5_SINGLE_CONFIGURE_OPTS += -no-optimize-debug

QT5_SINGLE_CFLAGS = $(TARGET_CFLAGS)
QT5_SINGLE_CXXFLAGS = $(TARGET_CXXFLAGS)

ifeq ($(BR2_TOOLCHAIN_HAS_GCC_BUG_90620),y)
QT5_SINGLE_CFLAGS += -O0
QT5_SINGLE_CXXFLAGS += -O0
endif

ifeq ($(BR2_X86_CPU_HAS_SSE2),)
QT5_SINGLE_CONFIGURE_OPTS += -no-sse2
else ifeq ($(BR2_X86_CPU_HAS_SSE3),)
QT5_SINGLE_CONFIGURE_OPTS += -no-sse3
else ifeq ($(BR2_X86_CPU_HAS_SSSE3),)
QT5_SINGLE_CONFIGURE_OPTS += -no-ssse3
else ifeq ($(BR2_X86_CPU_HAS_SSE4),)
QT5_SINGLE_CONFIGURE_OPTS += -no-sse4.1
else ifeq ($(BR2_X86_CPU_HAS_SSE42),)
QT5_SINGLE_CONFIGURE_OPTS += -no-sse4.2
else ifeq ($(BR2_X86_CPU_HAS_AVX),)
QT5_SINGLE_CONFIGURE_OPTS += -no-avx
else ifeq ($(BR2_X86_CPU_HAS_AVX2),)
QT5_SINGLE_CONFIGURE_OPTS += -no-avx2
else
# no buildroot BR2_X86_CPU_HAS_AVX512 option yet for qt configure
# option '-no-avx512'
endif

ifeq ($(BR2_PACKAGE_LIBDRM),y)
QT5_SINGLE_CONFIGURE_OPTS += -kms
QT5_SINGLE_DEPENDENCIES += libdrm
else
QT5_SINGLE_CONFIGURE_OPTS += -no-kms
endif

ifeq ($(BR2_PACKAGE_HAS_LIBGBM),y)
QT5_SINGLE_CONFIGURE_OPTS += -gbm
QT5_SINGLE_DEPENDENCIES += libgbm
else
QT5_SINGLE_CONFIGURE_OPTS += -no-gbm
endif

ifeq ($(BR2_ENABLE_RUNTIME_DEBUG),y)
QT5_SINGLE_CONFIGURE_OPTS += -debug
else
QT5_SINGLE_CONFIGURE_OPTS += -release
endif

QT5_SINGLE_CONFIGURE_OPTS += -opensource -confirm-license
QT5_SINGLE_LICENSE = GPL-2.0+ or LGPL-3.0, GPL-3.0 with exception(tools), GFDL-1.3 (docs)
QT5_SINGLE_LICENSE_FILES = LICENSE.GPL2 LICENSE.GPL3 LICENSE.GPL3-EXCEPT LICENSE.LGPLv3 LICENSE.FDL
ifeq ($(BR2_PACKAGE_QT5_SINGLE_EXAMPLES),y)
QT5_SINGLE_LICENSE += , BSD-3-Clause (examples)
endif

QT5_SINGLE_CONFIG_FILE = $(call qstrip,$(BR2_PACKAGE_QT5_SINGLE_CONFIG_FILE))

ifneq ($(QT5_SINGLE_CONFIG_FILE),)
QT5_SINGLE_CONFIGURE_OPTS += -qconfig buildroot
endif

ifeq ($(BR2_PACKAGE_HAS_UDEV),y)
QT5_SINGLE_DEPENDENCIES += udev
endif

ifeq ($(BR2_PACKAGE_CUPS), y)
QT5_SINGLE_DEPENDENCIES += cups
QT5_SINGLE_CONFIGURE_OPTS += -cups
else
QT5_SINGLE_CONFIGURE_OPTS += -no-cups
endif

ifeq ($(BR2_PACKAGE_ZSTD),y)
QT5_SINGLE_DEPENDENCIES += zstd
QT5_SINGLE_CONFIGURE_OPTS += -zstd
else
QT5_SINGLE_CONFIGURE_OPTS += -no-zstd
endif

# Qt5 SQL Plugins
ifeq ($(BR2_PACKAGE_QT5_SINGLE_SQL),y)
ifeq ($(BR2_PACKAGE_QT5_SINGLE_MYSQL),y)
QT5_SINGLE_CONFIGURE_OPTS += -plugin-sql-mysql -mysql_config $(STAGING_DIR)/usr/bin/mysql_config
QT5_SINGLE_DEPENDENCIES   += mysql
else
QT5_SINGLE_CONFIGURE_OPTS += -no-sql-mysql
endif

ifeq ($(BR2_PACKAGE_QT5_SINGLE_PSQL),y)
QT5_SINGLE_CONFIGURE_OPTS += -plugin-sql-psql -psql_config $(STAGING_DIR)/usr/bin/pg_config
QT5_SINGLE_DEPENDENCIES   += postgresql
else
QT5_SINGLE_CONFIGURE_OPTS += -no-sql-psql
endif

QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_SQLITE_QT),-plugin-sql-sqlite)
QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_SQLITE_SYSTEM),-system-sqlite)
QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_QT5_SINGLE_SQLITE_SYSTEM),sqlite)
QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_SQLITE_NONE),-no-sql-sqlite)
endif

ifeq ($(BR2_PACKAGE_QT5_SINGLE_GUI),y)
QT5_SINGLE_CONFIGURE_OPTS += -gui -system-freetype
QT5_SINGLE_DEPENDENCIES += freetype
else
QT5_SINGLE_CONFIGURE_OPTS += -no-gui -no-freetype
endif

ifeq ($(BR2_PACKAGE_QT5_SINGLE_HARFBUZZ),y)
ifeq ($(BR2_TOOLCHAIN_HAS_SYNC_4),y)
# system harfbuzz in case __sync for 4 bytes is supported
QT5_SINGLE_CONFIGURE_OPTS += -system-harfbuzz
QT5_SINGLE_DEPENDENCIES += harfbuzz
else
# qt harfbuzz otherwise (using QAtomic instead)
QT5_SINGLE_CONFIGURE_OPTS += -qt-harfbuzz
QT5_SINGLE_LICENSE += , MIT (harfbuzz)
QT5_SINGLE_LICENSE_FILES += src/3rdparty/harfbuzz-ng/COPYING
endif
else
QT5_SINGLE_CONFIGURE_OPTS += -no-harfbuzz
endif

QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_WIDGETS),-widgets,-no-widgets)
# We have to use --enable-linuxfb, otherwise Qt thinks that -linuxfb
# is to add a link against the "inuxfb" library.
QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_LINUXFB),--enable-linuxfb,-no-linuxfb)
QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_DIRECTFB),-directfb,-no-directfb)
QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_QT5_SINGLE_DIRECTFB),directfb)

ifeq ($(BR2_PACKAGE_LIBXKBCOMMON),y)
QT5_SINGLE_CONFIGURE_OPTS += -xkbcommon
QT5_SINGLE_DEPENDENCIES   += libxkbcommon
endif

ifeq ($(BR2_PACKAGE_QT5_SINGLE_XCB),y)
QT5_SINGLE_CONFIGURE_OPTS += -xcb

QT5_SINGLE_DEPENDENCIES   += \
	libxcb \
	xcb-util-wm \
	xcb-util-image \
	xcb-util-keysyms \
	xcb-util-renderutil \
	xlib_libX11
ifeq ($(BR2_PACKAGE_QT5_SINGLE_WIDGETS),y)
QT5_SINGLE_DEPENDENCIES   += xlib_libXext
endif
else
QT5_SINGLE_CONFIGURE_OPTS += -no-xcb
endif

ifeq ($(BR2_PACKAGE_QT5_SINGLE_OPENGL_DESKTOP),y)
QT5_SINGLE_CONFIGURE_OPTS += -opengl desktop
QT5_SINGLE_DEPENDENCIES   += libgl
else ifeq ($(BR2_PACKAGE_QT5_SINGLE_OPENGL_ES2),y)
QT5_SINGLE_CONFIGURE_OPTS += -opengl es2
QT5_SINGLE_DEPENDENCIES   += libgles
else
QT5_SINGLE_CONFIGURE_OPTS += -no-opengl
endif

QT5_SINGLE_DEFAULT_QPA = $(call qstrip,$(BR2_PACKAGE_QT5_SINGLE_DEFAULT_QPA))
QT5_SINGLE_CONFIGURE_OPTS += $(if $(QT5_SINGLE_DEFAULT_QPA),-qpa $(QT5_SINGLE_DEFAULT_QPA))

ifeq ($(BR2_arc),y)
# In case of -Os (which is default in BR) gcc will use millicode implementation
# from libgcc. That along with performance degradation may lead to issues during
# linkage stage. In case of QtWebkit exactly that happens - millicode functions
# get put way too far from caller functions and so linker fails.
# To solve that problem we explicitly disable millicode call generation for Qt.
# Also due to some Qt5 libs being really huge (the best example is QtWebKit)
# it's good to firce compiler to not assume short or even medium-length calls
# could be used. I.e. always use long jump instaructions.
# Otherwise there's a high risk of hitting link-time failures.
QT5_SINGLE_CFLAGS += -mno-millicode -mlong-calls
endif

ifeq ($(BR2_PACKAGE_QT5_SINGLE_EGLFS),y)
QT5_SINGLE_CONFIGURE_OPTS += -eglfs
QT5_SINGLE_DEPENDENCIES   += libegl
else
QT5_SINGLE_CONFIGURE_OPTS += -no-eglfs
endif

QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_OPENSSL),-openssl,-no-openssl)
QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_OPENSSL),openssl)

QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_FONTCONFIG),-fontconfig,-no-fontconfig)
QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_QT5_SINGLE_FONTCONFIG),fontconfig)
QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_GIF),,-no-gif)
QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_JPEG),-system-libjpeg,-no-libjpeg)
QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_QT5_SINGLE_JPEG),jpeg)
QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_PNG),-system-libpng,-no-libpng)
QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_QT5_SINGLE_PNG),libpng)

QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_DBUS),-dbus,-no-dbus)
QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_QT5_SINGLE_DBUS),dbus)

QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_TSLIB),-tslib,-no-tslib)
QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_QT5_SINGLE_TSLIB),tslib)

QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_MTDEV),-mtdev,-no-mtdev)
QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_QT5_SINGLE_MTDEV),mtdev)

QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_LIBGLIB2),-glib,-no-glib)
QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_LIBGLIB2),libglib2)

QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_LIBKRB5),libkrb5)

QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_ICU),-icu,-no-icu)
QT5_SINGLE_DEPENDENCIES   += $(if $(BR2_PACKAGE_QT5_SINGLE_ICU),icu)

QT5_SINGLE_CONFIGURE_OPTS += $(if $(BR2_PACKAGE_QT5_SINGLE_EXAMPLES),-make,-nomake) examples


ifeq ($(BR2_PACKAGE_QT5_SINGLE_3D),y)
	ifeq ($(BR2_PACKAGE_ASSIMP),y)
	QT5_SINGLE_DEPENDENCIES += assimp
	endif
else
	QT5_SINGLE_CONFIGURE_OPTS += -skip qt3d
endif



ifneq ($(BR2_PACKAGE_QT5_SINGLE_CHARTS),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtcharts
endif


ifeq ($(BR2_PACKAGE_QT5_SINGLE_CONNECTIVITY),y)
	QT5_SINGLE_DEPENDENCIES += $(if $(BR2_PACKAGE_BLUEZ5_UTILS),bluez5_utils)
	QT5_SINGLE_DEPENDENCIES += $(if $(BR2_PACKAGE_NEARD),neard)
else
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtconnectivity
endif


ifneq ($(BR2_PACKAGE_QT5_SINGLE_DECLARATIVE),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtdeclarative
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_GRAPHICALEFFECTS),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtgraphicaleffects
endif


ifneq ($(BR2_PACKAGE_QT5_SINGLE_IMAGEFORMATS),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtimageformats
endif


ifneq ($(BR2_PACKAGE_QT5_SINGLE_LOCATION),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtlocation
endif
ifeq ($(BR2_PACKAGE_QT5_SINGLE_MULTIMEDIA),y)
	ifeq ($(BR2_PACKAGE_GST1_PLUGINS_BASE),y)
	QT5_SINGLE_DEPENDENCIES += gst1-plugins-base
	endif

	ifeq ($(BR2_PACKAGE_LIBGLIB2)$(BR2_PACKAGE_PULSEAUDIO),yy)
	QT5_SINGLE_DEPENDENCIES += libglib2 pulseaudio
	endif

	ifeq ($(BR2_PACKAGE_ALSA_LIB),y)
	QT5_SINGLE_DEPENDENCIES += alsa-lib
	endif
else
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtmultimedia
endif


ifneq ($(BR2_PACKAGE_QT5_SINGLE_QUICKCONTROLS),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtquickcontrols
endif


ifneq ($(BR2_PACKAGE_QT5_SINGLE_QUICKCONTROLS2),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtquickcontrols2
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_QUICKTIMELINE),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtquicktimeline
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_REMOTEOBJECTS),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtremoteobjects
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_SCXML),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtscxml
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_SENSORS),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtsensors
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_SERIALBUS),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtserialbus
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_SERIALPORT),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtserialport
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_SVG),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtsvg
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_VIRTUALKEYBOARD),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtvirtualkeyboard
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_WEBCHANNEL),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtwebchannel
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_WEBSOCKETS),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtwebsockets
endif

ifneq ($(BR2_PACKAGE_QT5_SINGLE_XMLPATTERNS),y)
	QT5_SINGLE_CONFIGURE_OPTS += -skip qtxmlpatterns
endif

# 
#
# QT5_SINGLE_CONFIGURE_OPTS += $(if !$(BR2_PACKAGE_QT5_SINGLE_CHARTS),-skip )qtcharts
# QT5_SINGLE_CONFIGURE_OPTS += $(if !$(BR2_PACKAGE_QT5_SINGLE_CHARTS),-skip )qtcharts
# QT5_SINGLE_CONFIGURE_OPTS += $(if !$(BR2_PACKAGE_QT5_SINGLE_CHARTS),-skip )qtcharts



# see qt5base-5.15.2/src/corelib/global/qlogging.cpp:110 - __has_include(<execinfo.h>)
ifeq ($(BR2_PACKAGE_LIBEXECINFO),y)
QT5_SINGLE_DEPENDENCIES += libexecinfo
define QT5_SINGLE_CONFIGURE_ARCH_CONFIG_LIBEXECINFO
	printf '!host_build { \n LIBS += -lexecinfo\n }' >$(QT5_SINGLE_ARCH_CONFIG_FILE)
endef
endif

ifeq ($(BR2_PACKAGE_LIBINPUT),y)
QT5_SINGLE_CONFIGURE_OPTS += -libinput
QT5_SINGLE_DEPENDENCIES += libinput
else
QT5_SINGLE_CONFIGURE_OPTS += -no-libinput
endif

# only enable gtk support if libgtk3 X11 backend is enabled
ifeq ($(BR2_PACKAGE_LIBGTK3)$(BR2_PACKAGE_LIBGTK3_X11),yy)
QT5_SINGLE_CONFIGURE_OPTS += -gtk
QT5_SINGLE_DEPENDENCIES += libgtk3
else
QT5_SINGLE_CONFIGURE_OPTS += -no-gtk
endif

ifeq ($(BR2_PACKAGE_SYSTEMD),y)
QT5_SINGLE_CONFIGURE_OPTS += -journald
QT5_SINGLE_DEPENDENCIES += systemd
else
QT5_SINGLE_CONFIGURE_OPTS += -no-journald
endif

ifeq ($(BR2_PACKAGE_QT5_SINGLE_SYSLOG),y)
QT5_SINGLE_CONFIGURE_OPTS += -syslog
else
QT5_SINGLE_CONFIGURE_OPTS += -no-syslog
endif

ifeq ($(BR2_PACKAGE_IMX_GPU_VIV),y)
# use vivante backend
QT5_SINGLE_EGLFS_DEVICE = EGLFS_DEVICE_INTEGRATION = eglfs_viv
else ifeq ($(BR2_PACKAGE_SUNXI_MALI_UTGARD),y)
# use mali backend
QT5_SINGLE_EGLFS_DEVICE = EGLFS_DEVICE_INTEGRATION = eglfs_mali
else ifeq ($(BR2_PACKAGE_ROCKCHIP_MALI),y)
# use kms backend
QT5_SINGLE_EGLFS_DEVICE = EGLFS_DEVICE_INTEGRATION = eglfs_kms
else ifeq ($(BR2_PACKAGE_LIBMALI_MIDGARD),y)
# use kms backend
QT5_SINGLE_EGLFS_DEVICE = EGLFS_DEVICE_INTEGRATION = eglfs_kms
endif

ifneq ($(QT5_SINGLE_CONFIG_FILE),)
define QT5_SINGLE_CONFIGURE_CONFIG_FILE
	cp $(QT5_SINGLE_CONFIG_FILE) $(@D)/src/corelib/global/qconfig-buildroot.h
endef
endif

QT5_SINGLE_ARCH_CONFIG_FILE = $(@D)/qtbase/mkspecs/devices/linux-buildroot-g++/arch.conf
ifeq ($(BR2_TOOLCHAIN_HAS_LIBATOMIC),y)
# Qt 5.8 needs atomics, which on various architectures are in -latomic
define QT5_SINGLE_CONFIGURE_ARCH_CONFIG_LIBATOMIC
	printf '!host_build { \n LIBS += -latomic\n }' >$(QT5_SINGLE_ARCH_CONFIG_FILE)
endef
endif

ifeq ($(ARCH),'aarch64')
define QT5_SINGLE_CONFIGURE_ARCH_CONFIG_DISTRO_OPTS
	printf ' DISTRO_OPTS += aarch64' >$(QT5_SINGLE_ARCH_CONFIG_FILE)
endef
endif

# This allows to use ccache when available
define QT5_SINGLE_CONFIGURE_HOSTCC
	$(SED) 's,^QMAKE_CC\s*=.*,QMAKE_CC = $(HOSTCC),' $(@D)/qtbase/mkspecs/common/g++-base.conf
	$(SED) 's,^QMAKE_CXX\s*=.*,QMAKE_CXX = $(HOSTCXX),' $(@D)/qtbase/mkspecs/common/g++-base.conf
endef



# Must be last so can override all options set by Buildroot
QT5_SINGLE_CONFIGURE_OPTS += $(call qstrip,$(BR2_PACKAGE_QT5_SINGLE_CUSTOM_CONF_OPTS))

define QT5_SINGLE_CONFIGURE_CMDS
	mkdir -p $(@D)/qtbase/mkspecs/devices/linux-buildroot-g++/
	sed 's/@EGLFS_DEVICE@/$(QT5_SINGLE_EGLFS_DEVICE)/g' \
		$(QT5_SINGLE_PKGDIR)/qmake.conf.in > \
		$(@D)/qtbase/mkspecs/devices/linux-buildroot-g++/qmake.conf
	$(INSTALL) -m 0644 -D $(QT5_SINGLE_PKGDIR)/qplatformdefs.h \
		$(@D)/qtbase/mkspecs/devices/linux-buildroot-g++/qplatformdefs.h
	$(QT5_SINGLE_CONFIGURE_CONFIG_FILE)
	touch $(QT5_SINGLE_ARCH_CONFIG_FILE)
	$(QT5_SINGLE_CONFIGURE_ARCH_CONFIG_LIBATOMIC)
	$(QT5_SINGLE_CONFIGURE_ARCH_CONFIG_LIBEXECINFO)
	$(QT5_SINGLE_CONFIGURE_ARCH_CONFIG_DISTRO_OPTS)
	$(QT5_SINGLE_CONFIGURE_HOSTCC)
	(cd $(@D); \
		$(TARGET_MAKE_ENV) \
		PKG_CONFIG="$(PKG_CONFIG_HOST_BINARY)" \
		MAKEFLAGS="-j$(PARALLEL_JOBS) $(MAKEFLAGS)" \
		./configure \
		-v \
		-prefix /opt/qt5 \
		-hostprefix $(HOST_DIR)/opt/qt5 \
		-sysroot $(STAGING_DIR) \
		-nomake tests \
		-device linux-buildroot-g++ \
		-device-option CROSS_COMPILE="$(TARGET_CROSS)" \
		-device-option BR_COMPILER_CFLAGS="$(QT5_SINGLE_CFLAGS)" \
		-device-option BR_COMPILER_CXXFLAGS="$(QT5_SINGLE_CXXFLAGS)" \
		$(QT5_SINGLE_CONFIGURE_OPTS) \
	)
endef

# define QT5_SINGLE_BUILD_CMDS
# 	$$(TARGET_MAKE_ENV) $$(QT5_SINGLE_MAKE_ENV) $$(MAKE) -C $$(QT5_SINGLE_BUILDDIR) $$(QT5_SINGLE_MAKE_OPTS)
# endef
# 
# QT5_SINGLE_INSTALL_STAGING_OPTS	?= install
# 
# define QT5_SINGLE_INSTALL_STAGING_CMDS
# 	$$(TARGET_MAKE_ENV) $$(QT5_SINGLE_MAKE_ENV) $$(MAKE) -C $$(QT5_SINGLE_BUILDDIR) $$(QT5_SINGLE_INSTALL_STAGING_OPTS)
# endef
# 
# define QT5_SINGLE_INSTALL_TARGET_CMDS
# # 	$$(TARGET_MAKE_ENV) $$(QT5_SINGLE_MAKE_ENV) $$(MAKE) -C $$(QT5_SINGLE_BUILDDIR) INSTALL_ROOT=$$(QT5_SINGLE_BUILDDIR)tmp-target-install $$(QT5_SINGLE_INSTALL_TARGET_OPTS)
# # 	rsync -arv $$(QT5_SINGLE_BUILDDIR)tmp-target-install$$(STAGING_DIR)/ $$(TARGET_DIR)/
# endef

# QT5_SINGLE_POST_INSTALL_STAGING_HOOKS += QT5_SINGLE_INSTALL_QT_CONF

QT5_SINGLE_QMAKE = $(HOST_DIR)/bin/qmake -spec devices/linux-buildroot-g++

# include $(sort $(wildcard $(BR2_EXTERNAL_OrangePi_4_PATH)/package/qt5_single/*/*.mk))

# $(eval $(generic-package))
# $(call inner-generic-package,qt5_single,QT5_SINGLE,QT5_SINGLE )

$(eval $(qmake-single-package))
