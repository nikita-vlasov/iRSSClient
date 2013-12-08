#import <UIKit/UIKit.h>
#import "Internet.h"
#import "RSSParser.h"
#import "DetailViewController.h"

@interface TableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    @private
    NSArray *arrayDataRss;
}

#pragma mark - Action
- (IBAction)buttonBarRefresh:(id)sender;

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;

#pragma mark -
@property (strong, nonatomic) NSString *linkToTheRssFeeds;

@end
