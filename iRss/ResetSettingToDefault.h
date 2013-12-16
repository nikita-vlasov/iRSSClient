#import <Foundation/Foundation.h>
#import "SQLiteAccess.h"

@interface ResetSettingToDefault : NSObject {
    @public
//    NSUserDefaults *userDefaults;
}

#pragma mark SQL
+ (void)cleanerListFavorites;
+ (void)cleanerAllRssChanel;

#pragma mark -
+ (void)resetFontSize;
+ (void)resetTipsSwitch;
+ (void)resetWarningSwitch;

@end
