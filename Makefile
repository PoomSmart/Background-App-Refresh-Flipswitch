PACKAGE_VERSION = 1.0.0
TARGET = iphone:clang:latest:11.0

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = BackgroundAppRefreshFS
BackgroundAppRefreshFS_FILES = Switch.xm
BackgroundAppRefreshFS_PRIVATE_FRAMEWORKS = ManagedConfiguration
BackgroundAppRefreshFS_LIBRARIES = flipswitch
BackgroundAppRefreshFS_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk
