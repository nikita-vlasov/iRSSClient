#import <Foundation/Foundation.h>

@interface NSDate (Date)

/** Возвращает отформатированую дату в формате (yyyy/MM/dd HH:mm). */
+ (NSString *)getFormattetDateSetDate:(NSDate *)date;

@end
