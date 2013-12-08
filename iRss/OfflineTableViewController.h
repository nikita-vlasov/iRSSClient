#import <UIKit/UIKit.h>
#import "DetailViewController.h"
#import "SQLiteAccess.h"

@interface OfflineTableViewController : UITableViewController {
    
}

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;

#pragma mark -
- (NSArray *)arrayDataRssOffline;

@end
