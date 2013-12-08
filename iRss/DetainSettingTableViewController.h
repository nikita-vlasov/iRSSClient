#import <UIKit/UIKit.h>

@interface DetainSettingTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    
}

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;

#pragma mark -
@property (strong, nonatomic) NSString *stringCellLabel;
@property (strong, nonatomic) NSString *stringTitleForFooterSection;

@end
