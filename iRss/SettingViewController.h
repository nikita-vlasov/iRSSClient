#import <UIKit/UIKit.h>
#import "DetailSettingTableViewController.h"
#import "ResetSettingToDefault.h"

@interface SettingViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    @private
    NSArray *arrayPoints;
}

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
