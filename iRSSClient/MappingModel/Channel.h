#import <Foundation/Foundation.h>

@interface Channel : NSObject

/** Заголовок канала. */
@property (strong, nonatomic) NSString *title;
/** Описание канала. */
@property (strong, nonatomic) NSString *designation;
/** Ссылка на канал. */
@property (strong, nonatomic) NSString *link;

@end