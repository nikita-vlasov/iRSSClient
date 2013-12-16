#import "SettingViewController.h"

@interface SettingViewController () {
    
}

@end


@implementation SettingViewController

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self navigationItem] setTitle:NSLocalizedString(@"SETTING", nil)];
    
    UIBarButtonItem *newBackButton= [[UIBarButtonItem alloc] initWithTitle:nil
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:nil
                                                                    action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    switchButton = [[UISwitch alloc] initWithFrame:CGRectZero];
    [switchButton addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    
    userDefaults = [NSUserDefaults standardUserDefaults];

    
    [switchButton setOn:[userDefaults boolForKey:@"SWITCH_TIPS_BOOL"] animated:YES];
    mfMailComposeViewController = [[MFMailComposeViewController alloc] init];
    
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 
- (void)switchChanged:(id)sender {
    UISwitch* switchControl = sender;
    int binary;
    
    if (switchControl.on) {
        binary = YES;
    }
    else {
        binary = NO;
    }

    [userDefaults setBool:binary forKey:@"SWITCH_TIPS_BOOL"];
    [userDefaults synchronize];
    [[self tableView] reloadData];
    
    NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //Сколько секций в таблице всего
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //сколько ячеек в секции
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    if (section == 2) {
        return 1;
    }
    if (section == 3) {
        return 1;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UITableViewCell *switchCell = [tableView dequeueReusableCellWithIdentifier:@"SwitchButton"];
    UITableViewCell *cellButtonReset = [tableView dequeueReusableCellWithIdentifier:@"CellButton"];

    /* Section - 0 */
    if ([indexPath section] == 0) {
        if ([indexPath row] == 0) {
        [[cell textLabel] setText:NSLocalizedString(@"ABOUT", nil)];
        return cell;
        }
    }
    /* Section - 2 */
    if ([indexPath section] == 2) {
        if ([indexPath row] == 0) {
            [[cellButtonReset textLabel] setText:NSLocalizedString(@"SEND_REPORT", nil)];
            return cellButtonReset;
        }
    }
    if ([indexPath section] == 1) {
        if ([indexPath row] == 0) {
            [[switchCell textLabel] setText:NSLocalizedString(@"TIPS", nil)];
            switchCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switchCell.accessoryView = switchButton;
            return switchCell;
        }
    }
    /* Section - 3 */
    if ([indexPath section] == 3) {
        if ([indexPath row] == 0) {
            [[cellButtonReset textLabel] setText:NSLocalizedString(@"RESET", nil)];
            return cellButtonReset;
        }
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if ([userDefaults boolForKey:@"SWITCH_TIPS_BOOL"] == YES) {
        if (section == 0) {
            return NSLocalizedString(@"INFO_APP", nil);
        }
        if (section == 1) {
            return NSLocalizedString(@"TIPS_DESCRIPTION", nil);
        }
        if (section == 2) {
            return NSLocalizedString(@"SEND_REPORT_ERROR", nil);
        }
        if (section == 3) {
            return NSLocalizedString(@"RESET_CONT_AND_SETING", nil);
        }
    }
    return nil;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /* Section - 1 switch */
    if ([indexPath section] == 1) {
        if ([indexPath row] == 0) {
        }
    }
    /* Section - 2 (Send Report) */
    if ([indexPath section] == 2) {
        if ([indexPath row] == 0) {
            [self sendEmail];
        }
    }
    /* Section - 3 (Reset content and Setting) */
    if ([indexPath section] == 3) {
        if ([indexPath row] == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"WARNING", nil)
                                                                message:NSLocalizedString(@"RESET_SETTING", nil)
                                                               delegate:self
                                                      cancelButtonTitle:NSLocalizedString(@"DELETE", nil)
                                                      otherButtonTitles:NSLocalizedString(@"CANCEL", nil), nil];
            [alertView show];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            [ResetSettingToDefault resetFontSize];
            [ResetSettingToDefault cleanerListFavorites];
            [ResetSettingToDefault cleanerAllRssChanel];
            [ResetSettingToDefault resetTipsSwitch];
            [switchButton setOn:YES animated:YES];
            [[self tableView] reloadData];
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - SendReport
- (void)sendEmail {
    NSString *stringSubject = [NSString stringWithFormat:@"iRss | Version - %@", [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
    
    mfMailComposeViewController.mailComposeDelegate = self;
    [mfMailComposeViewController setToRecipients:@[@"alex.kovalskiy@icloud.com"]];
    [mfMailComposeViewController setSubject:stringSubject];
    [self presentViewController:mfMailComposeViewController animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error; {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Array
- (NSArray *)arrayTitle {
    return @[NSLocalizedString(@"NAME_APPS", nil),
             NSLocalizedString(@"VERSION_APPS", nil)];
}

- (NSArray *)arrayDiscription {
    return @[[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"],
             [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    DetailSettingTableViewController *detainSettingTableViewController = [segue destinationViewController];
    
    if ([indexPath section] == 0) {
        if ([indexPath row] == 0) {
            [detainSettingTableViewController setArrayTitle:[self arrayTitle]];
            [detainSettingTableViewController setArrayDescription:[self arrayDiscription]];
            [detainSettingTableViewController setCountNumberRows:2];
        }
    }
}

@end
