#import "Client.h"

@implementation Client

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

#pragma mark - SQL Query Select
+ (void)deleteRssChannel:(NSString *)idChannel {
    NSString *query = [[NSString alloc] initWithFormat:@"DELETE FROM add_rss WHERE id_rss_chanel = '%@'", idChannel];
    [SQLiteAccess deleteWithSQL:query];
}

@end
