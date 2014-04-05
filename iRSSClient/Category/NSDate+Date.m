#import "NSDate+Date.h"

@implementation NSDate (Date)

+ (NSString *)getFormattetDateSetDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd HH:mm"];
    NSString *formatterDate = [dateFormatter stringFromDate:date];

    return formatterDate;
}

@end
