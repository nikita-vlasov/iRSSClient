#import "Client.h"

@implementation Client

#pragma mark - SQL Query Add
+ (void)addNewChannelSetTitle:(NSString *)title setLink:(NSString *)link {
    NSString *query = [[NSString alloc] initWithFormat:@"INSERT INTO add_rss (title, link) VALUES ('%@', '%@')", title, link];
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
+ (void)deleteRssChannel:(NSString *)idChannel {
    NSString *query = [[NSString alloc] initWithFormat:@"DELETE FROM add_rss WHERE id_rss_chanel = '%@'", idChannel];
    [SQLiteAccess deleteWithSQL:query];
}

+ (void)deleteFavoritesNotes:(NSString *)idNews {
    NSString *query = [[NSString alloc] initWithFormat:@"DELETE FROM offline WHERE id = '%@'", idNews];
    [SQLiteAccess deleteWithSQL:query];
}

@end
