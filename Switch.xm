#import <Foundation/Foundation.h>
#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>

@interface BackgroundAppRefreshSwitch : NSObject <FSSwitchDataSource>
@end

@interface MCProfileConnection : NSObject
+ (instancetype)sharedConnection;
- (BOOL)isAutomaticAppUpdatesAllowed;
- (void)setAutomaticAppUpdatesAllowed:(BOOL)allowed;
@end

@implementation BackgroundAppRefreshSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier {
	BOOL enabled = [[%c(MCProfileConnection) sharedConnection] isAutomaticAppUpdatesAllowed] && ![[NSProcessInfo processInfo] isLowPowerModeEnabled];
	return enabled ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier {
	if (newState == FSSwitchStateIndeterminate)
		return;
	[[%c(MCProfileConnection) sharedConnection] setAutomaticAppUpdatesAllowed:newState == FSSwitchStateOn];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("kKeepAppsUpToDateEnabledChangedNotification"), nil, nil, YES);
}

- (void)applyAlternateActionForSwitchIdentifier:(NSString *)switchIdentifier {
	NSURL *url = [NSURL URLWithString:@"prefs:root=General&path=AUTO_CONTENT_DOWNLOAD/AUTO_CONTENT_DOWNLOAD"];
	[[FSSwitchPanel sharedPanel] openURLAsAlternateAction:url];
}

@end
