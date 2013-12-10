#import "Database.h"
#import "SQLiteAccess.h"

@implementation Database

- (BOOL)requestToLink:(NSString *)link {
    
    NSString *str = @"http://support.apple.com/kb/HT5956  ";
    NSString *query = [[NSString alloc] initWithFormat:@"SELECT link FROM offline WHERE link = '%@'", str];
    NSString *yyy = [SQLiteAccess selectOneValueSQL:query];
 
    
    
    NSLog(@"%@", yyy);
    
    
    if (yyy == NULL) {
        return NO;
    }
    else {
        return YES;
    }
}

@end
