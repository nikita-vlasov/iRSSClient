#import <UIKit/UIKit.h>

@interface SettingViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    @private
    NSArray *array;
}

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
