#import <Foundation/Foundation.h>

@interface Channel : NSObject

/** Заголовок канала. */
@property (strong, nonatomic) NSString *title;
/** Описание канала. */
@property (strong, nonatomic) NSString *designation;
/** Ссылка на канал. */
@property (strong, nonatomic) NSString *link;
/** Дата создания канала. */
@property (strong, nonatomic) NSString *createDate;
/** Прочитана статья 1-Да/0-Нет. */
@property (nonatomic) Boolean *isRead;
/** Добавлена в список для чтения 1-ДА/0-Нет. */
@property (nonatomic) Boolean *isFavorites;

@end
