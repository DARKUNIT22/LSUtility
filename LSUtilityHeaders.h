@interface SBApplicationController
+ (id)sharedInstance;
- (SBApplication*)applicationWithDisplayIdentifier:(NSString*)identifier;
@end

@interface SBUIController
+ (id)sharedInstance;
- (void)activateApplicationFromSwitcher:(SBApplication*)app;
@end

@interface SBLockScreenSlideUpToAppController
- (void)setTargetApp:(id)arg1 withLSInfo:(id)arg2;
- (void)setGrabberViewImage:(id)arg1;
@end

@interface ALApplicationList
+ (id)sharedApplicationList;
- (UIImage *)iconOfSize:(int)iconSize forDisplayIdentifier:(NSString *)displayIdentifier;
@end

@interface SBSlideUpAppGrabberView
- (void)setGrabberImageFromApp:(id)arg1;
@end
