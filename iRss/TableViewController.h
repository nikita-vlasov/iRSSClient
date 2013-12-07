#import <UIKit/UIKit.h>
#import "Internet.h"
#import "RSSParser.h"
#import "UIImageView+AFNetworking.h"

@interface TableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    @private
    NSArray *arrayDataRss;
}

#pragma mark - Action
- (IBAction)buttonBarRefresh:(id)sender;

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;


@end
