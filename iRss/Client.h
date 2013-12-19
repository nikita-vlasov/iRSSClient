#import <Foundation/Foundation.h>
#import "NSDateFormatter+DateFormatter.h"
#import "SQLiteAccess.h"

@interface Client : NSObject {
    
}

#pragma mark - SQL Query Add
+ (void)addNewChannelSetTitle:(NSString *)title setLink:(NSString *)link;
+ (void)addNewNewsSetTitle:(NSString *)title setDescription:(NSString *)description setContent:(NSString *)content setLink:(NSURL *)link setCommentsLink:(NSURL *)commentsLink setCommentsFeed:(NSURL *)commentsFeed setCommentsCount:(NSNumber *)commentsCount setPubDate:(NSString *)pubDate setAuthor:(NSString *)author setGuid:(NSString *)guid setCategory:(NSString *)category;

#pragma mark - SQL Query Update
+ (void)updateChannelSetTitle:(NSString *)title setLink:(NSString *)link setIdChannel:(NSString *)idChannel;

#pragma mark - SQL Query Select
+ (NSArray *)selectAllChannelDesc;
+ (NSArray *)selectAllChannelByTitle;
+ (NSArray *)selectAllFavoritesNotes;

#pragma mark - SQL Query Delete
+ (void)deleteAllFavorites;
+ (void)deleteAllRssChanel;
+ (void)deleteRssChannel:(NSString *)idChannel;
+ (void)deleteFavoritesNotes:(NSString *)idNews;

@end
