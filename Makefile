DEBUG = 0
PACKAGE_VERSION = 0.0.2

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BARToggle
BARToggle_FILES = Switch.xm
BARToggle_PRIVATEFRAMEWORKS = ManagedConfiguration
BARToggle_LIBRARIES = flipswitch
BARToggle_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk