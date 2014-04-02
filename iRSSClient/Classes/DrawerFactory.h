#import <Foundation/Foundation.h>
#import "MMDrawerController.h"

#import "LeftController.h"

/**
 * Класс для реализации меню - слайда.
 */

@class MMDrawerController;

@interface DrawerFactory : NSObject

#pragma mark -
+ (DrawerFactory *)sharedFactory;

#pragma mark - UIViewController
- (LeftController *)leftController;

#pragma mark - Others
- (void)createLeftMenu;
- (void)removeAllControllers;

@end
