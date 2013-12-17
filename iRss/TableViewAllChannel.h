#import <UIKit/UIKit.h>
#import "TableViewController.h"
#import "EditChannelTableViewController.h"
#import "SQLiteAccess.h"

@interface TableViewAllChannel : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    @private
    UIBarButtonItem *barButtonAddChannel;
    UIBarButtonItem *barButtonDeleteAllChannel;
    
        NSDictionary *dictionaryRssChannel;
}

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UITableView *tableView;

#pragma mark -
- (NSArray *)arrayGetAllRssChannel;

@end
