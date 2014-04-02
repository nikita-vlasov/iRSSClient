#import <Foundation/Foundation.h>
#import "MMDrawerController.h"

#import "LeftController.h"

@class MMDrawerController;

@interface DrawerFactory : NSObject

#pragma mark -
+ (DrawerFactory *)sharedFactory;

#pragma mark - UIViewController
- (LeftController *)leftController;

@end
