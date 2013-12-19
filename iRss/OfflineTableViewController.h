#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "SQLiteAccess.h"
#import "ResetSettingToDefault.h"
#import "Client.h"

@interface OfflineTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    @private
    UIBarButtonItem *buttonDeleteAll;
    UIBarButtonItem *barButtonDone;
}

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;

#pragma mark -
- (NSArray *)arrayAllFavoritesNotes;

@end
