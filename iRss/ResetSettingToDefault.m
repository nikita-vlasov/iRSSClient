#import "ResetSettingToDefault.h"

@implementation ResetSettingToDefault

#pragma mark -
+ (void)resetFontSize {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:14 forKey:@"FONT_SIZE"];
    [userDefaults synchronize];
}

@end
