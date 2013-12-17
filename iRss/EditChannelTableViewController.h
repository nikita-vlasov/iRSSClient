#import <UIKit/UIKit.h>
#import "CustomCellEditChannel.h"
#import "SQLiteAccess.h"

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
/* Определяет с какой целью был выполнен переход на этот контролер. */
@property (strong, nonatomic) NSString *stringAddKey;
@property (strong, nonatomic) NSDictionary *dictionaryRssChannel;

@end
