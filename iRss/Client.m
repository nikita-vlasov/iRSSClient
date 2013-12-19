#import "Client.h"

@implementation Client

#pragma mark - SQL Query Add
+ (void)addNewChannelSetTitle:(NSString *)title setLink:(NSString *)link {
    NSString *query = [[NSString alloc] initWithFormat:@"INSERT INTO add_rss (title, link) VALUES ('%@', '%@')", title, link];
    [SQLiteAccess insertWithSQL:query];
}

+ (void)addNewNewsSetTitle:(NSString *)title setDescription:(NSString *)description setContent:(NSString *)content setLink:(NSURL *)link setCommentsLink:(NSURL *)commentsLink setCommentsFeed:(NSURL *)commentsFeed setCommentsCount:(NSNumber *)commentsCount setPubDate:(NSString *)pubDate setAuthor:(NSString *)author setGuid:(NSString *)guid setCategory:(NSString *)category {
    
    NSString *dateTime = [NSDateFormatter todayDateTime];
    NSString *query = [NSString stringWithFormat:@"INSERT INTO offline (title, item_description, content, link, comments_link, comments_feed, comments_count, pub_date, author, guid, category, date_added) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')", title, description, content, link, commentsLink, commentsFeed,commentsCount, pubDate, author, guid, category, dateTime];
    [SQLiteAccess insertWithSQL:query];
}

#pragma mark - SQL Query Update
+ (void)updateChannelSetTitle:(NSString *)title setLink:(NSString *)link setIdChannel:(NSString *)idChannel {
    NSString *query = [[NSString alloc] initWithFormat:@"UPDATE add_rss SET title = '%@', link = '%@' WHERE id_rss_chanel = '%@'", title, link, idChannel];
    [SQLiteAccess updateWithSQL:query];
}

#pragma mark - SQL Query Select
+ (NSArray *)selectAllChannelDesc {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM add_rss ORDER BY id_rss_chanel DESC"];
}

+ (NSArray *)selectAllChannelByTitle {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM add_rss ORDER BY title"];
}

+ (NSArray *)selectAllFavoritesNotes {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM offline ORDER BY date_added DESC"];
}

#pragma mark - SQL Query Delete
+ (void)deleteAllRssChanel {
    [SQLiteAccess deleteWithSQL:@"DELETE FROM add_rss"];
}

+ (void)deleteAllFavorites {
    [SQLiteAccess deleteWithSQL:@"DELETE FROM offline"];
}

+ (void)deleteRssChannel:(NSString *)idChannel {
    NSString *query = [[NSString alloc] initWithFormat:@"DELETE FROM add_rss WHERE id_rss_chanel = '%@'", idChannel];
    [SQLiteAccess deleteWithSQL:query];
}

+ (void)deleteFavoritesNotes:(NSString *)idNews {
    NSString *query = [[NSString alloc] initWithFormat:@"DELETE FROM offline WHERE id = '%@'", idNews];
    [SQLiteAccess deleteWithSQL:query];
}

@end
