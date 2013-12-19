#import "Client.h"

@implementation Client

+ (NSArray *)selectAllChannelDesc {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM add_rss ORDER BY id_rss_chanel DESC"];
}

@end
