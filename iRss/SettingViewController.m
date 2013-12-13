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
    self.navigationItem.title = NSLocalizedString(@"SETTING", nil);
    
    mfMailComposeViewController = [[MFMailComposeViewController alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //Сколько секций в таблице всего
    return 3;
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
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    UITableViewCell *cellButtonReset = [tableView dequeueReusableCellWithIdentifier:@"CellButtonReset"];

    /* Section - 0 */
    if ([indexPath section] == 0) {
        if ([indexPath row] == 0) {
        [[cell textLabel] setText:@"About"];
        return cell;
        }
    }
    /* Section - 1 */
    if ([indexPath section] == 1) {
        if (indexPath.row == 0) {
            [[cellButtonReset textLabel] setText:@"Send the report"];
            return cellButtonReset;
        }
    }
    /* Section - 2 */
    if ([indexPath section] == 2) {
        if ([indexPath row] == 0) {
            [[cellButtonReset textLabel] setText:@"Reset"];
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
    if (section == 0) {
        return @"Here you can see information about the application and about the author.";
    }
    if (section == 1) {
        return @"You found an error? Please send us a description of the error, we will try to fix it soon and would be very grateful to you.";
    }
    if (section == 2) {
        return @"This function allows you to remove the content and reset all settings to factory default. Think before you click. This action may not be undone!";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
    
    /* Section - 1 */
    if ([indexPath section] == 1) {
        if ([indexPath row] == 0) {
            [self sendEmail];
        }
    }
    /* Section - 2 */
    if ([indexPath section] == 2) {
        if ([indexPath row] == 0) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning"
                                                                message:@"Do you really want to delete all content and reset all settings?"
                                                               delegate:self
                                                      cancelButtonTitle:@"Delete"
                                                      otherButtonTitles:@"Cancel", nil];
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
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - SendReport
- (void)sendEmail {
    mfMailComposeViewController.mailComposeDelegate = self;
    [mfMailComposeViewController setToRecipients:@[@"alex.kovalskiy@icloud.com"]];
    [mfMailComposeViewController setSubject:@"iRss | Fail"];
    [mfMailComposeViewController setMessageBody:@"" isHTML:YES];
    [self presentViewController:mfMailComposeViewController animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error; {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Array
- (NSArray *)arrayTitle {
    return @[@"Version of the program",
             @"Name",
             @"Last name"];
}

- (NSArray *)arrayDiscription {
    return @[[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
             @"Alex",
             @"Zarochoncev",];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    DetailSettingTableViewController *detainSettingTableViewController = [segue destinationViewController];
    
    if ([indexPath section] == 0) {
        if ([indexPath row] == 0) {
            [detainSettingTableViewController setArrayTitle:[self arrayTitle]];
            [detainSettingTableViewController setArrayDescription:[self arrayDiscription]];
            [detainSettingTableViewController setCountNumberRows:3];
        }
    }
}

@end
