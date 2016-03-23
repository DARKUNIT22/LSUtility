@class SBApplication, SBLockScreenSlideUpToAppController, SBSlideUpAppGrabberView;

#import "LSUtilityHeaders.h"

BOOL LSUisEnabled = YES;
BOOL HideDateisEnabled = NO;
BOOL HideCameraGrabberisEnabled = NO;
BOOL cameraGrabberQuickLaunchisEnabled = NO;
BOOL isCustomUnlock = NO;
NSString *cameraGrabberDisplayIdentifier = nil;
NSString *unlockText = nil;
NSString *dateText = nil;

NSString *prefsPath = @"/var/mobile/Library/Preferences/com.unit22.lsutilityprefs.plist";
#define PrefsFileName "com.unit22.lsutilityprefs"

void loadPrefs();

%group iOS8
    %hook SpringBoard

    - (_Bool)canShowLockScreenCameraGrabber {

        if ((LSUisEnabled) && (HideCameraGrabberisEnabled)) {
            return FALSE;
        } else {
            return %orig;
        }
    }
    %end

    %hook SBLockScreenDateViewController

    - (void)setCustomSubtitleText:(id)arg1 withColor:(id)arg2 {

        //loadPrefs();

        if ((LSUisEnabled) && (![dateText isEqualToString:@""])) {
            arg1 = dateText;
        }
        %orig(arg1, arg2);
    }
    %end

    %hook SBLockScreenViewController

    -(BOOL) _shouldShowDate {

        if ((LSUisEnabled) && (HideDateisEnabled)) {
            return FALSE;
        } else {
            return %orig;
        }
    }

    - (void)updateCustomSubtitleTextForAwayViewPlugin:(id)arg1 {

        if ((LSUisEnabled) && (![dateText isEqualToString:@""])) {
            arg1 = dateText;
        }
        %orig(arg1);
    }

    /*- (id)lockScreenCameraController {

        if((LSUisEnabled) && (cameraGrabberQuickLaunchisEnabled)) {
            if ((!cameraGrabberDisplayIdentifier || [cameraGrabberDisplayIdentifier isEqualToString:@"com.apple.camera"])) {
                NSLog(@"###Returning Original###");
                return %orig;
            } else {
                NSLog(@"###Setting up customAppController...###");
                SBLockScreenSlideUpToAppController *customAppController = MSHookIvar<SBLockScreenSlideUpToAppController *>(self, "_cameraController");

                NSLog(@"###Successfull hook into _cameraController var now setting target app to launch###");
                SBApplication *application = [[%c(SBApplicationController) sharedInstance] applicationWithDisplayIdentifier:cameraGrabberDisplayIdentifier];

                //UIImage *grabberImageView = [[NSClassFromString(@"ALApplicationList") sharedApplicationList] iconOfSize:29 forDisplayIdentifier:cameraGrabberDisplayIdentifier];
                //UIImageView *grabberImageView = [[%c(UIImageView) alloc] initWithImage:[[NSClassFromString(@"ALApplicationList") sharedApplicationList] iconOfSize:29 forDisplayIdentifier:cameraGrabberDisplayIdentifier]];

                [customAppController setGrabberViewImage:grabberImageView];
                [customAppController setTargetApp:application withLSInfo:nil];
                //[grabberImageView release];

                return customAppController;
            }
        } else {
            return %orig;
        }
    }*/

    - (void)loadView {

        %orig;

        if((LSUisEnabled) && (cameraGrabberQuickLaunchisEnabled)) {
            if ((cameraGrabberDisplayIdentifier && (![cameraGrabberDisplayIdentifier isEqualToString:@"com.apple.camera"]))) {

                SBLockScreenSlideUpToAppController *customAppController = MSHookIvar<SBLockScreenSlideUpToAppController *>(self, "_cameraController");

                SBApplication *application = [[%c(SBApplicationController) sharedInstance] applicationWithDisplayIdentifier:cameraGrabberDisplayIdentifier];

                UIImage *grabberImageView = [[NSClassFromString(@"ALApplicationList") sharedApplicationList] iconOfSize:29 forDisplayIdentifier:cameraGrabberDisplayIdentifier];

                [customAppController setGrabberViewImage:grabberImageView];
                [customAppController setTargetApp:application withLSInfo:nil];
            }
        }
    }

    - (void)viewWillAppear:(_Bool)arg1 {

        %orig;

        if((LSUisEnabled) && (cameraGrabberQuickLaunchisEnabled)) {
            if ((cameraGrabberDisplayIdentifier && (![cameraGrabberDisplayIdentifier isEqualToString:@"com.apple.camera"]))) {

                SBLockScreenSlideUpToAppController *customAppController = MSHookIvar<SBLockScreenSlideUpToAppController *>(self, "_cameraController");

                //SBApplication *application = [[%c(SBApplicationController) sharedInstance] applicationWithDisplayIdentifier:cameraGrabberDisplayIdentifier];

                UIImage *grabberImageView = [[NSClassFromString(@"ALApplicationList") sharedApplicationList] iconOfSize:29 forDisplayIdentifier:cameraGrabberDisplayIdentifier];

                [customAppController setGrabberViewImage:grabberImageView];
                //[customAppController setTargetApp:application withLSInfo:nil];
            }
        }
    }

    - (id)_lockscreenViewCreatingIfNecessary {

        if((LSUisEnabled) && (cameraGrabberQuickLaunchisEnabled)) {
            if ((cameraGrabberDisplayIdentifier && (![cameraGrabberDisplayIdentifier isEqualToString:@"com.apple.camera"]))) {

                SBLockScreenSlideUpToAppController *customAppController = MSHookIvar<SBLockScreenSlideUpToAppController *>(self, "_cameraController");

                //SBApplication *application = [[%c(SBApplicationController) sharedInstance] applicationWithDisplayIdentifier:cameraGrabberDisplayIdentifier];

                UIImage *grabberImageView = [[NSClassFromString(@"ALApplicationList") sharedApplicationList] iconOfSize:29 forDisplayIdentifier:cameraGrabberDisplayIdentifier];

                [customAppController setGrabberViewImage:grabberImageView];
                //[customAppController setTargetApp:application withLSInfo:nil];
            }
        }
        return %orig;
    }

    %end

    %hook SBLockScreenView

    - (void)setCustomSlideToUnlockText:(id)arg1 animated:(_Bool)arg2 {

        //loadPrefs();

        if((LSUisEnabled) && (![unlockText isEqualToString:@""])) {
            arg1 = unlockText;
            arg2 = FALSE;
        }

        %orig(arg1, arg2);
    }

    - (void)_layoutCameraGrabberView {

        %orig;

        if((LSUisEnabled) && (cameraGrabberQuickLaunchisEnabled)) {
            if ((cameraGrabberDisplayIdentifier && (![cameraGrabberDisplayIdentifier isEqualToString:@"com.apple.camera"]))) {

                SBApplication *application = [[%c(SBApplicationController) sharedInstance] applicationWithDisplayIdentifier:cameraGrabberDisplayIdentifier];

                SBSlideUpAppGrabberView *cameraGrabberView = MSHookIvar<SBSlideUpAppGrabberView *>(self, "_cameraGrabberView");

                [cameraGrabberView setGrabberImageFromApp:application];
            }
        }
    }

    /*- (void)setBottomLeftGrabberHidden:(_Bool)arg1 forRequestor:(id)arg2 {

        if((LSUisEnabled) && (QuickLaunchisEnabled)) {
            arg1 = FALSE;
        }
        %orig(arg1, arg2);
    }

    - (_Bool)isBottomLeftGrabberHidden {
        BOOL val = %orig;

        if((LSUisEnabled) && (QuickLaunchisEnabled)) {
            val = FALSE;
            return val;
        } else {
            return val;
        }
    }*/

    %end

    %hook SBLockScreenView

    - (void)setCameraGrabberHidden:(BOOL)hidden forRequester:(id)requestor {

        if ((LSUisEnabled) && (HideCameraGrabberisEnabled)) {
            hidden = TRUE;
        }

        %orig(hidden, requestor);
    }

    %end
%end

%group iOS9
    %hook SBFLockScreenDateView

    - (void)setCustomSubtitleText:(id)arg1 withColor:(id)arg2 {

        //loadPrefs();

        if ((LSUisEnabled) && (![dateText isEqualToString:@""])) {
            arg1 = dateText;
        }
        %orig(arg1, arg2);
    }
    
    - (BOOL)isDateHidden {
    
        if ((LSUisEnabled) && (HideDateisEnabled)) {
            return TRUE;
        } else {
            return FALSE;
        }
    }
    %end
%end

//Preference setup/parsing.
void loadPrefs() {

    CFPreferencesAppSynchronize(CFSTR(PrefsFileName));

    //NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:prefsPath];
    //NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsPath];

    LSUisEnabled = !CFPreferencesCopyAppValue(CFSTR("LSUisEnabled"), CFSTR(PrefsFileName)) ? YES : [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("LSUisEnabled"), CFSTR(PrefsFileName))) boolValue];
    //LSUisEnabled = [[prefs objectForKey:@"LSUisEnabled"] boolValue];

    unlockText = !CFPreferencesCopyAppValue(CFSTR("unlockText"), CFSTR(PrefsFileName)) ? @"" : (NSString *)CFPreferencesCopyAppValue(CFSTR("unlockText"), CFSTR(PrefsFileName));
    //unlockText = [prefs objectForKey:@"unlockText"];

    HideDateisEnabled = !CFPreferencesCopyAppValue(CFSTR("HideDateisEnabled"), CFSTR(PrefsFileName)) ? NO : [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("HideDateisEnabled"), CFSTR(PrefsFileName))) boolValue];
    //HideDateisEnabled = [[prefs objectForKey:@"HideDateisEnabled"] boolValue];

    dateText = !CFPreferencesCopyAppValue(CFSTR("dateText"), CFSTR(PrefsFileName)) ? @"" : (NSString *)CFPreferencesCopyAppValue(CFSTR("dateText"), CFSTR(PrefsFileName));
    //dateText = [prefs objectForKey:@"dateText"];

    HideCameraGrabberisEnabled = !CFPreferencesCopyAppValue(CFSTR("HideCameraGrabberisEnabled"), CFSTR(PrefsFileName)) ? YES : [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("HideCameraGrabberisEnabled"), CFSTR(PrefsFileName))) boolValue];
    //HideCameraGrabberisEnabled = [[prefs objectForKey:@"HideCameraGrabberisEnabled"] boolValue];

    cameraGrabberQuickLaunchisEnabled = !CFPreferencesCopyAppValue(CFSTR("cameraGrabberQuickLaunchisEnabled"), CFSTR(PrefsFileName)) ? NO : [(id)CFBridgingRelease(CFPreferencesCopyAppValue(CFSTR("cameraGrabberQuickLaunchisEnabled"), CFSTR(PrefsFileName))) boolValue];

    cameraGrabberDisplayIdentifier = !CFPreferencesCopyAppValue(CFSTR("cameraSelectedApp"), CFSTR(PrefsFileName)) ? @"" : (NSString *)CFPreferencesCopyAppValue(CFSTR("cameraSelectedApp"), CFSTR(PrefsFileName));

}

static void settingsNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    loadPrefs();
}

%ctor {

    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

    CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();

    CFNotificationCenterAddObserver(r,
                                    NULL,
                                    &settingsNotification,
                                    CFSTR("com.unit22.lsutilityprefs/settingschanged"),
                                    NULL,
                                    0);
    settingsNotification(NULL, NULL, NULL, NULL, NULL);
    [pool drain];

    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) {
        NSLog(@"###Using iOS 9 group...###");
        %init(iOS9);
    } else {
        %init(iOS8);
    }
}