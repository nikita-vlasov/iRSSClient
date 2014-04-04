#import <Foundation/Foundation.h>

@interface LeftModel : NSObject

#pragma mark - NSString
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *key;

#pragma mark - Other
+ (NSMutableArray *)createLeftMenu;

@end
