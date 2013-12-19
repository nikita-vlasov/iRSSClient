#import <UIKit/UIKit.h>
#import "DetailSettingTableViewController.h"
#import "ResetSettingToDefault.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "Client.h"

@interface SettingViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate> {
    @private
    UISwitch *buttonSwitchTips;
    UISwitch *buttonSwitchWarning;
    UISwitch *buttonSwitchSortChannel;
    
    NSUserDefaults *userDefaults;
    
    MFMailComposeViewController *mfMailComposeViewController;
}

#pragma mark - Action
- (IBAction)barButtonDone:(id)sender;

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
