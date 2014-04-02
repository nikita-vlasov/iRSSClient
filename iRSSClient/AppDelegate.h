#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

#pragma mark - UIWindow
@property (strong, nonatomic) UIWindow *window;

#pragma mark - NSManagedObjectContext
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;

#pragma mark - NSManagedObjectModel
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;

#pragma mark - NSPersistentStoreCoordinator
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

#pragma mark - Other
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
