#import <Foundation/Foundation.h>

@interface Internet : NSObject

#pragma mark -
/** Метод проверяет интернет соединение запросом на Google.com. Возвращает BOOL (либо интернет есть, либо нет). */
+ (BOOL)internetConnection;

@end
