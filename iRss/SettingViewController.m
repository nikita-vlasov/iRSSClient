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
    userDefaults = [NSUserDefaults standardUserDefaults];
    mfMailComposeViewController = [[MFMailComposeViewController alloc] init];
    
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    buttonSwitchTips = [[UISwitch alloc] initWithFrame:CGRectZero];
    [buttonSwitchTips addTarget:self action:@selector(switchTips:) forControlEvents:UIControlEventValueChanged];
    [buttonSwitchTips setOn:[userDefaults boolForKey:@"SWITCH_TIPS_BOOL"] animated:YES];
    
    buttonSwitchWarning = [[UISwitch alloc] initWithFrame:CGRectZero];
    [buttonSwitchWarning addTarget:self action:@selector(switchWarning:) forControlEvents:UIControlEventValueChanged];
    [buttonSwitchWarning setOn:[userDefaults boolForKey:@"SWITCH_WARNING_BOOL"] animated:YES];
    
    buttonSwitchSortChannel = [[UISwitch alloc] initWithFrame:CGRectZero];
    [buttonSwitchSortChannel addTarget:self action:@selector(switchSortChannel:) forControlEvents:UIControlEventValueChanged];
    [buttonSwitchSortChannel setOn:[userDefaults boolForKey:@"SWITCH_SORT_CHANNEL_BOOL"] animated:YES];
    
    
    [[self tableView] reloadData];
}

#pragma mark - Bar Button
- (IBAction)barButtonDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Button Switch
- (void)switchTips:(id)switchTipsSender {
    UISwitch *switchControl = switchTipsSender;
    BOOL binary;
    
    if (switchControl.on) {
        binary = YES;
    }
    else {
        binary = NO;
    }
    [self boolAction:binary and:@"SWITCH_TIPS_BOOL"];
}

- (void)switchWarning:(id)switchWarning {
    UISwitch *switchControl = switchWarning;
    BOOL binary;
    
    if (switchControl.on) {
        binary = YES;
    }
    else {
        binary = NO;
    }
    [self boolAction:binary and:@"SWITCH_WARNING_BOOL"];
}

- (void)switchSortChannel:(id)switchSortChannel {
    UISwitch *switchControl = switchSortChannel;
    BOOL binary;
    if (switchControl.on) {
        binary = YES;
    }
    else {
        binary = NO;
    }
    [self boolAction:binary and:@"SWITCH_SORT_CHANNEL_BOOL"];
}

#pragma mark - Void
- (void)boolAction:(BOOL)boolIdentifer and:(NSString *)stringKey {
    [userDefaults setBool:boolIdentifer forKey:stringKey];
    [userDefaults synchronize];
    [[self tableView] reloadData];
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
        return 3;
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
    /* Section - 1 SWitch button */
    if ([indexPath section] == 1) {
        if ([indexPath row] == 0) {
            [[switchCell textLabel] setText:NSLocalizedString(@"TIPS", nil)];
            switchCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switchCell.accessoryView = buttonSwitchTips;
            return switchCell;
        }
        if ([indexPath row] == 1) {
            [[switchCell textLabel] setText:NSLocalizedString(@"WARNING", nil)];
            switchCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switchCell.accessoryView = buttonSwitchWarning;
            return switchCell;
        }
        if ([indexPath row] == 2) {
            [[switchCell textLabel] setText:NSLocalizedString(@"SORT_CHANNEL", nil)];
            switchCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            switchCell.accessoryView = buttonSwitchSortChannel;
            //SWITCH_SORT_CHANNEL_BOOL
            return switchCell;
        }
    }
    /* Section - 2 */
    if ([indexPath section] == 2) {
        if ([indexPath row] == 0) {
            [[cellButtonReset textLabel] setText:NSLocalizedString(@"SEND_REPORT", nil)];
            return cellButtonReset;
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
            if ([userDefaults boolForKey:@"SWITCH_WARNING_BOOL"] == YES) {
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"WARNING", nil)
                                                                    message:NSLocalizedString(@"RESET_SETTING", nil)
                                                                   delegate:self
                                                          cancelButtonTitle:NSLocalizedString(@"DELETE", nil)
                                                          otherButtonTitles:NSLocalizedString(@"CANCEL", nil), nil];
            [alertView show];
            }
            else {
                [self resetAllSetting];
            }
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            [self resetAllSetting];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)resetAllSetting {
    [ResetSettingToDefault resetFontSize];
    [ResetSettingToDefault cleanerListFavorites];
    [ResetSettingToDefault cleanerAllRssChanel];
    
    [ResetSettingToDefault resetTipsSwitch];
    [buttonSwitchTips setOn:YES animated:YES];
    
    [ResetSettingToDefault resetWarningSwitch];
    [buttonSwitchWarning setOn:YES animated:YES];
    
    [ResetSettingToDefault resetSortChannelSwitch];
    [buttonSwitchSortChannel setOn:YES animated:YES];
    
    [[self tableView] reloadData];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
