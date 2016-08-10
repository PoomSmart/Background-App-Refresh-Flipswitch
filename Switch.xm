#import <Flipswitch/FSSwitchDataSource.h>
#import <Flipswitch/FSSwitchPanel.h>

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
	return [[%c(MCProfileConnection) sharedConnection] isAutomaticAppUpdatesAllowed] ? FSSwitchStateOn : FSSwitchStateOff;
}

- (void)applyState:(FSSwitchState)newState forSwitchIdentifier:(NSString *)switchIdentifier
{
	if (newState == FSSwitchStateIndeterminate)
		return;
	[[%c(MCProfileConnection) sharedConnection] setAutomaticAppUpdatesAllowed:newState == FSSwitchStateOn];
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("kKeepAppsUpToDateEnabledChangedNotification"), nil, nil, NO);
}

@end