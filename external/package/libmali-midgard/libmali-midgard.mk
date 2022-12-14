################################################################################
#
# libmali-midgard
#
################################################################################

LIBMALI_MIDGARD_VERSION = 8f79d9779786328410d19559fb66932b7b6ae74d
LIBMALI_MIDGARD_SITE = $(call github,radxa,libmali,$(LIBMALI_MIDGARD_VERSION))
BR_NO_CHECK_HASH_FOR += libmali-midgard-8f79d9779786328410d19559fb66932b7b6ae74d.tar.gz

# LIBMALI_MIDGARD_VERSION = 309268f7a34ca0bba0ab94a0b09feb0191c77fb8
# LIBMALI_MIDGARD_SITE = https://github.com/JeffyCN/mirrors
# # LIBMALI_MIDGARD_SITE = $(call github,effyCN,mirrors,$(LIBMALI_MIDGARD_VERSION))
# LIBMALI_MIDGARD_SITE_METHOD = git


######
#  for this one you should download archive manualy
#  and put it in $(BR2_EXTERNAL)/package/libmali-midgard/src directory
#  using this command: wget https://github.com/JeffyCN/mirrors/archive/libmali.tar.gz
##
# LIBMALI_MIDGARD_SITE = file://$(BR2_EXTERNAL)/package/libmali-midgard/src
# LIBMALI_MIDGARD_SOURCE = libmali-midgard.tar.gz
# LIBMALI_MIDGARD_METHOD = file
# BR_NO_CHECK_HASH_FOR += libmali-midgard.tar.gz

LIBMALI_MIDGARD_LICENSE = Proprietary
LIBMALI_MIDGARD_LICENSE_FILES = END_USER_LICENCE_AGREEMENT.txt
LIBMALI_MIDGARD_INSTALL_STAGING = YES
LIBMALI_MIDGARD_DEPENDENCIES = host-patchelf libdrm
LIBMALI_MIDGARD_PROVIDES = libegl libgles libgbm

LIBMALI_MIDGARD_LIB = libmali-midgard-t86x-r18p0-$(LIBMALI_MIDGARD_SUFFIX).so
LIBMALI_MIDGARD_PKGCONFIG_FILES = egl gbm glesv2 mali
LIBMALI_MIDGARD_ARCH_DIR = $(if $(BR2_arm),arm-linux-gnueabihf,aarch64-linux-gnu)
LIBMALI_MIDGARD_HEADERS = EGL FBDEV GLES GLES2 GLES3 KHR GBM

# We need to create:
# - The symlink that matches the library SONAME (libmali.so.1)
# - The .so symlinks needed at compile time by the compiler (*.so)
LIBMALI_MIDGARD_LIB_SYMLINKS = \
	libmali.so.1 \
	libMali.so \
	libEGL.so \
	libgbm.so \
	libGLESv1_CM.so \
	libGLESv2.so

ifeq ($(BR2_PACKAGE_WAYLAND),y)
LIBMALI_MIDGARD_SUFFIX = wayland-gbm
LIBMALI_MIDGARD_PKGCONFIG_FILES += wayland-egl
LIBMALI_MIDGARD_LIB_SYMLINKS += libwayland-egl.so
LIBMALI_MIDGARD_DEPENDENCIES += wayland
else
LIBMALI_MIDGARD_SUFFIX = gbm
endif

define LIBMALI_MIDGARD_INSTALL_CMDS
# 	Install the library
	$(INSTALL) -D -m 0755 \
		$(@D)/lib/$(LIBMALI_MIDGARD_ARCH_DIR)/$(LIBMALI_MIDGARD_LIB) \
		$(1)/usr/lib/$(LIBMALI_MIDGARD_LIB)

# 	Ensure it has a proper soname
	$(HOST_DIR)/bin/patchelf --set-soname libmali.so.1 \
		$(1)/usr/lib/$(LIBMALI_MIDGARD_LIB)

#	Generate and install the .pc files
	mkdir -p $(1)/usr/lib/pkgconfig
	$(foreach pkgconfig,$(LIBMALI_MIDGARD_PKGCONFIG_FILES), \
		sed -e 's%@CMAKE_INSTALL_LIBDIR@%lib%;s%@CMAKE_INSTALL_INCLUDEDIR@%include%' \
			$(@D)/pkgconfig/$(pkgconfig).pc.cmake > \
			$(1)/usr/lib/pkgconfig/$(pkgconfig).pc
	)

#	Install all headers
	$(foreach d,$(LIBMALI_MIDGARD_HEADERS), \
		cp -dpfr $(@D)/include/$(d) $(1)/usr/include/
	)

#	Create symlinks
	$(foreach symlink,$(LIBMALI_MIDGARD_LIB_SYMLINKS), \
		ln -sf $(LIBMALI_MIDGARD_LIB) $(1)/usr/lib/$(symlink)
	)
endef

define LIBMALI_MIDGARD_INSTALL_TARGET_CMDS
	$(call LIBMALI_MIDGARD_INSTALL_CMDS,$(TARGET_DIR))
endef

define LIBMALI_MIDGARD_INSTALL_STAGING_CMDS
	$(call LIBMALI_MIDGARD_INSTALL_CMDS,$(STAGING_DIR))
endef

$(eval $(generic-package))
