#import "ResetSettingToDefault.h"

@implementation ResetSettingToDefault

#pragma mark -
+ (void)resetFontSize {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:14 forKey:@"FONT_SIZE"];
    [userDefaults synchronize];
}

+ (void)resetFontSizeOnlyText {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:20 forKey:@"FONT_SIZE_DESCRIPTION"];
    [userDefaults synchronize];
}

#pragma mark - Switch Button
+ (void)resetTipsSwitch {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"SWITCH_TIPS_BOOL"];
    [userDefaults synchronize];
}

+ (void)resetWarningSwitch {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"SWITCH_WARNING_BOOL"];
    [userDefaults synchronize];
}

+ (void)resetSortChannelSwitch {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"SWITCH_SORT_CHANNEL_BOOL"];
    [userDefaults synchronize];
}

@end
