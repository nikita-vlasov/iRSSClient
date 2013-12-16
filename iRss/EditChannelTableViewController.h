#import <UIKit/UIKit.h>
#import "CustomCellEditChannel.h"

@interface EditChannelTableViewController : UITableViewController <UITableViewDataSource, UITabBarDelegate> {
    @private
    NSString *stringTitle;
    NSString *stringLink;
    NSString *stringDescription;    
}

#pragma mark - Action
- (IBAction)buttonBarSave:(id)sender;
- (IBAction)buttonBarCancel:(id)sender;

#pragma mark - Outlet
@property (strong, nonatomic, readwrite) IBOutlet UITableView *tableView;

@end
