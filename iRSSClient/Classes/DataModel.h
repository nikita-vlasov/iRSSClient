#import <Foundation/Foundation.h>

@interface DataModel : NSObject
+ (DataModel *)sharedModel;

/** Возвращает все данные из сущности. */
- (NSArray *)entityDataSetEnturyName:(NSString *)entityName;

@end
