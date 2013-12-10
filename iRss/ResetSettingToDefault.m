#import "ResetSettingToDefault.h"

@implementation ResetSettingToDefault

#pragma mark -
+ (void)cleanerListFavorites {
    NSString *queryString = [[NSString alloc] initWithFormat:@"DELETE FROM offline"];
    [SQLiteAccess deleteWithSQL:queryString];
}

#pragma mark -
+ (void)resetFontSize {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:14 forKey:@"FONT_SIZE"];
    [userDefaults synchronize];
}

@end
