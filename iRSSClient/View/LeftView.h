#import <UIKit/UIKit.h>

@interface LeftView : UIView

#pragma mark - UITableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIRefreshControl *refreshControl;

@end
