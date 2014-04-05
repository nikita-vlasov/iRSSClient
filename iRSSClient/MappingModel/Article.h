#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (strong, nonatomic) NSString *author;
@property (strong, nonatomic) NSString *comments_feed;
@property (strong, nonatomic) NSString *comments_link;
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *guid;
@property (strong, nonatomic) NSString *item_description;
@property (strong, nonatomic) NSString *link;
@property (strong, nonatomic) NSDate *pub_date;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSNumber *comments_count;


@end
