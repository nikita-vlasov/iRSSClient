#import <UIKit/UIKit.h>

@interface LeftView : UIView

#pragma mark - UITableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

#pragma mark - UISearchBar
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

#pragma mark - UIRefreshControl
@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end
