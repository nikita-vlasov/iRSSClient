#import <UIKit/UIKit.h>
#import "CustomCellEditChannel.h"
#import "SQLiteAccess.h"
#import "SelectionTableViewController.h"

@interface EditChannelTableViewController : UITableViewController <UITableViewDataSource, UITabBarDelegate> {
    @private
    NSString *stringTitle;
    NSString *stringLink;
    NSString *stringDescription;    
}

#pragma mark - Action
- (IBAction)buttonBarSave:(id)sender;

#pragma mark - Outlet
@property (strong ,nonatomic, readwrite) IBOutlet UITableView *tableView;

#pragma mark - 
@property (strong, nonatomic) NSDictionary *dictionaryRssChannel;

@end
