#import <Preferences/Preferences.h>
#import <UIKit/UIKit.h>

NSString *prefsPath = @"/var/mobile/Library/Preferences/com.unit22.lsutilityprefs.plist";
NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:prefsPath];

@interface LSUtilityPrefsListController: PSListController {
}
@end

@interface LSUtilitySliderPrefsListController: PSListController {
}
@end

@interface LSUtilityDatePrefsListController: PSListController {
}
@end

@interface LSUtilityGrabberPrefsListController: PSListController {
}
@end

@implementation LSUtilityPrefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"LSUtilityPrefs" target:self] retain];
	}
	return _specifiers;
}
@end

@implementation LSUtilitySliderPrefsListController
- (id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"LSUtilitySliderPrefs" target:self] retain];
    }
    return _specifiers;
}

- (void)didSave {
    //CFNotificationCenterRef r = CFNotificationCenterGetDarwinNotifyCenter();
    //CFNotificationCenterPostNotification(r, CFSTR("com.unit22.lsutilityprefs/settingschanged"), NULL, (CFDictionaryRef)prefs, true);
    [self.view endEditing:YES];
}
@end

@implementation LSUtilityDatePrefsListController
- (id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"LSUtilityDatePrefs" target:self] retain];
    }
    return _specifiers;
}

- (void)didSave {
    [self.view endEditing:YES];
}
@end

@implementation LSUtilityGrabberPrefsListController
- (id)specifiers {
    if(_specifiers == nil) {
        _specifiers = [[self loadSpecifiersFromPlistName:@"LSUtilityGrabberPrefs" target:self] retain];
        
        UIBarButtonItem *respringButton([[UIBarButtonItem alloc] initWithTitle:@"Respring" style:UIBarButtonItemStyleDone target:self action:@selector(repsringDevice)]);
        
        [[self navigationItem] setRightBarButtonItem:respringButton];
        [respringButton release];
    }
    return _specifiers;
}

- (void)repsringDevice {
    //[[(SpringBoard *)UIApplication sharedApplication] _relaunchSpringBoardNow];
}

@end





// vim:ft=objc
