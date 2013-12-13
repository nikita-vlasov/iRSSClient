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

    //Section - 0
    if (indexPath.section == 0) {
        if ([indexPath row] == 0) {
        [[cell textLabel] setText:@"About"];
        return cell;
        }
    }
    
    //Section - 1
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [[cellButtonReset textLabel] setText:@"Send the report"];
            return cellButtonReset;
        }
    }
    
    //Section - 2
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
        return @"Here you can see information about the application.";
    }
    if (section == 1) {
        return @"Сбросить контент и насройки.";
    }
    if (section == 2) {
        return @"Сбросить контент и насройки.";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%@", indexPath);
    
    if ([indexPath section] == 1) {
        if ([indexPath row] == 0) {
            [self sendEmail];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - SendReport
- (void)sendEmail {
    mfMailComposeViewController.mailComposeDelegate = self;
    [mfMailComposeViewController setSubject:@"saf"];
    [mfMailComposeViewController setMessageBody:@"sfds" isHTML:YES];
    [self presentViewController:mfMailComposeViewController animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error; {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    DetailSettingTableViewController *detainSettingTableViewController = [segue destinationViewController];
    
    if ([indexPath section] == 0) {
        if ([indexPath row] == 0) {
            
            NSArray *arrayTitle = [NSArray arrayWithObjects:
                                   @"Version of the program",
                                   @"Name",
                                   @"Last name", nil];
            
            NSArray *arrayDiscription = [NSArray arrayWithObjects:
                                         [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"],
                                         @"Alex",
                                         @"Zarochoncev",
                                         nil];
            
            [detainSettingTableViewController setArrayTitle:arrayTitle];
            [detainSettingTableViewController setArrayDescription:arrayDiscription];
            [detainSettingTableViewController setCountNumberRows:3];
        }
    }
    /*
    else if ([indexPath section] == 1) {
        [detainSettingTableViewController setStringCellLabel:@"Этот раздел в стадии разработки"];
    }
    else if ([indexPath section] == 2) {
        [ResetSettingToDefault resetFontSize];
        [ResetSettingToDefault cleanerListFavorites];
        [ResetSettingToDefault cleanerAllRssChanel];
        [detainSettingTableViewController setStringCellLabel:@"Settings are reset."];
    }
     */
}

@end
