#import <Foundation/Foundation.h>
#import "SQLiteAccess.h"

@interface Client : NSObject {
    
}

#pragma mark - SQL Query Select
+ (NSArray *)selectAllChannelDesc;
+ (NSArray *)selectAllChannelByTitle;
+ (NSArray *)selectAllFavoritesNotes;

#pragma mark - SQL Query Delete
+ (void)deleteRssChannel:(NSString *)idChannel;
+ (void)deleteFavoritesNotes:(NSString *)idNews;

@end
