#import <UIKit/UIKit.h>
#import "DetailSettingTableViewController.h"
#import "ResetSettingToDefault.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface SettingViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate> {
    @private
    UISwitch *switchButton;
    
    NSUserDefaults *userDefaults;
    
    MFMailComposeViewController *mfMailComposeViewController;
}

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
