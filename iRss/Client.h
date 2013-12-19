#import <Foundation/Foundation.h>
#import "SQLiteAccess.h"

@interface Client : NSObject {
    
}

#pragma mark - SQL Query Select
+ (NSArray *)selectAllChannelDesc;
+ (NSArray *)selectAllChannelByTitle;

#pragma mark - SQL Query Delete
+ (void)deleteRssChannel:(NSString *)idChannel;

@end
