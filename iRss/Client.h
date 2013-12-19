#import <Foundation/Foundation.h>
#import "SQLiteAccess.h"

@interface Client : NSObject {
    
}

#pragma mark - SQL Select
+ (NSArray *)selectAllChannelDesc;
+ (NSArray *)selectAllChannelByTitle;

@end
