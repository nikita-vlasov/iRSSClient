#import "ResetSettingToDefault.h"

@implementation ResetSettingToDefault

#pragma mark - SQL
+ (void)cleanerListFavorites {
    NSString *queryString = [[NSString alloc] initWithFormat:@"DELETE FROM offline"];
    [SQLiteAccess deleteWithSQL:queryString];
}

+ (void)cleanerAllRssChanel {
    NSString *queryString = [[NSString alloc] initWithFormat:@"DELETE FROM add_rss"];
    [SQLiteAccess deleteWithSQL:queryString];
}

#pragma mark -
+ (void)resetFontSize {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:14 forKey:@"FONT_SIZE"];
    [userDefaults synchronize];
}

+ (void)resetTipsSwitch {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:YES forKey:@"SWITCH_TIPS_BOOL"];
    [userDefaults synchronize];
}

@end
