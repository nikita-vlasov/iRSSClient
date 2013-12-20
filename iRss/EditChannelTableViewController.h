#import <UIKit/UIKit.h>
#import "CustomCellEditChannel.h"
#import "Client.h"

@interface EditChannelTableViewController : UITableViewController <UITableViewDataSource, UITabBarDelegate> {
    @private
    NSString *stringTitle;
    NSString *stringLink;
}

#pragma mark - Action
- (IBAction)buttonBarSave:(id)sender;

#pragma mark - Outlet
@property (strong ,nonatomic, readwrite) IBOutlet UITableView *tableView;

#pragma mark -
@property (strong, nonatomic) NSDictionary *dictionaryRssChannel;

@end
