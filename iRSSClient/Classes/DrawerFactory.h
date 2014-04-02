#import <Foundation/Foundation.h>
#import "MMDrawerController.h"
#import "DashboardController.h"
#import "ChannelController.h"

#import "LeftController.h"

/**
 * Класс для реализации меню - слайда.
 */

@class MMDrawerController;

@interface DrawerFactory : NSObject

#pragma mark -
+ (DrawerFactory *)sharedFactory;

#pragma mark - UIViewController
- (MMDrawerController *)drawerViewController;

- (LeftController *)leftController;
- (DashboardController *)dashboardController;
- (ChannelController *)channelController;

#pragma mark - Others
- (void)createLeftMenu;
- (void)removeAllControllers;

@end
