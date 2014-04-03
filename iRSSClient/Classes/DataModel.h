#import <Foundation/Foundation.h>

@interface DataModel : NSObject
+ (DataModel *)sharedModel;

- (NSArray *)entityDataSetEnturyName:(NSString *)entityName;

@end
