#import "NSDateFormatter+DateFormatter.h"

@implementation NSDateFormatter (DateFormatter)

#pragma mark -
+ (NSString *)todayDateTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

@end
