#import "Client.h"

@implementation Client

#pragma mark - SQL Select
+ (NSArray *)selectAllChannelDesc {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM add_rss ORDER BY id_rss_chanel DESC"];
}

+ (NSArray *)selectAllChannelByTitle {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM add_rss ORDER BY title"];
}

@end
