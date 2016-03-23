ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest:8.0
include theos/makefiles/common.mk

TWEAK_NAME = LSUtility
LSUtility_FILES = Tweak.xm
LSUtility_FRAMEWORKS = UIKit, Foundation
LSUtility_LDFLAGS += -Wl,-segalign,4000

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard; killall -9 backboardd"
SUBPROJECTS += lsutilityprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
