#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>
#import "../../PS.h"

@interface BARToggleSwitch : NSObject <FSSwitchDataSource>
@end

@interface MCProfileConnection : NSObject
+ (id)sharedConnection;
- (BOOL)isAutomaticAppUpdatesAllowed;
- (void)setAutomaticAppUpdatesAllowed:(BOOL)allow;
@end

@implementation BARToggleSwitch

- (FSSwitchState)stateForSwitchIdentifier:(NSString *)switchIdentifier
{
	BOOL enabled = [[%c(MCProfileConnection) sharedConnection] isAutomaticAppUpdatesAllowed];
	if (isiOS9Up)
		enabled &= ![[NSProcessInfo processInfo] isLowPowerModeEnabled];
	return enabled ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;
	[[%c(MCProfileConnection) sharedConnection] setAutomaticAppUpdatesAllowed:newState == FSSwitchStateOn];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("kKeepAppsUpToDateEnabledChangedNotification"), nil, nil, YES);
}

- (void)applyAlternateActionForSwitchIdentifier:(NSString *)switchIdentifier
{
	NSURL *url = [NSURL URLWithString:@"prefs:root=General&path=AUTO_CONTENT_DOWNLOAD/AUTO_CONTENT_DOWNLOAD"];
	[[FSSwitchPanel sharedPanel] openURLAsAlternateAction:url];
}

@end
