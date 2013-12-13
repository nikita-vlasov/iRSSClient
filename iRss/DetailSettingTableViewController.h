#import <UIKit/UIKit.h>

@interface DetailSettingTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate> {
    
}

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;

#pragma mark -
@property (strong, nonatomic) NSString *stringCellLabel;
@property (strong, nonatomic) NSString *stringCellDetailLabel;
@property (strong, nonatomic) NSString *stringTitleForFooterSection;

#pragma mark -
@property (nonatomic) NSInteger countNumberRows;

@property (strong, nonatomic) NSArray *arrayTitle;
@property (strong, nonatomic) NSArray *arrayDescription;

@end
