Target = iphone:clang:latest
ARCHS = armv7 armv7s arm64
include theos/makefiles/common.mk

BUNDLE_NAME = LSUtilityPrefs
LSUtilityPrefs_FILES = LSUtilityPrefs.mm
LSUtilityPrefs_INSTALL_PATH = /Library/PreferenceBundles
LSUtilityPrefs_FRAMEWORKS = UIKit
LSUtilityPrefs_PRIVATE_FRAMEWORKS = Preferences
LSUtilityPrefs_LIBRARIES = applist

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/LSUtilityPrefs.plist$(ECHO_END)
