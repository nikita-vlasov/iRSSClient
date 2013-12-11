#import <Foundation/Foundation.h>
#import "SQLiteAccess.h"

@interface ResetSettingToDefault : NSObject {
    
}

#pragma mark SQL
+ (void)cleanerListFavorites;
+ (void)cleanerAllRssChanel;

#pragma mark -
+ (void)resetFontSize;

@end
