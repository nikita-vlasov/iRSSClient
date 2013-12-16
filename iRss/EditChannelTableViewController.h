#import <UIKit/UIKit.h>

@interface EditChannelTableViewController : UITableViewController <UITableViewDataSource, UITabBarDelegate> {
    @private
    NSString *stringTitle;
    NSString *stringLink;
    NSString *stringDescription;    
}

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
