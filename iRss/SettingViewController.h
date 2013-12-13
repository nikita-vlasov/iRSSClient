#import <UIKit/UIKit.h>
#import "DetailSettingTableViewController.h"
#import "ResetSettingToDefault.h"
#import <Social/Social.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface SettingViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate> {
    @private
    SLComposeViewController *slComposeViewController;
    MFMailComposeViewController *mfMailComposeViewController;
}

#pragma mark - Outlet
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
