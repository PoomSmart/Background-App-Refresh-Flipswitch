ARCHS = armv7 arm64

include theos/makefiles/common.mk

BUNDLE_NAME = BARToggle
BARToggle_FILES = Switch.xm
BARToggle_FRAMEWORKS = UIKit
BARToggle_PRIVATEFRAMEWORKS = ManagedConfiguration
BARToggle_LIBRARIES = flipswitch
BARToggle_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk