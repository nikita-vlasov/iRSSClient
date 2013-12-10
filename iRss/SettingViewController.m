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
    arrayPoints = [NSArray arrayWithObjects:NSLocalizedString(@"ABOUT", nil), NSLocalizedString(@"REPORT_AN_ISSUE", nil), @"Reset", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [arrayPoints count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [arrayPoints objectAtIndex:indexPath.section];
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

/*
 - (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 return @"Apple";
 }
*/

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (section == 0) {
        return @"Here you can see information about the application.";
    }
    if (section == 1) {
        return @"You found an error? Please send us a message about your problem.";
    }
    if (section == 2) {
        return @"You can reset all settings to default. Do you really want to do this?";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailSettingTableViewController *detainSettingTableViewController = [segue destinationViewController];
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    
    if ([indexPath section] == 0) {
        [detainSettingTableViewController setStringCellLabel:[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]];
        [detainSettingTableViewController setStringTitleForFooterSection:@"This version of the program."];
    }
    else if ([indexPath section] == 1) {
        [detainSettingTableViewController setStringCellLabel:@"Этот раздел в стадии разработки"];
    }
    else if ([indexPath section] == 2) {
        [ResetSettingToDefault resetFontSize];
        [ResetSettingToDefault cleanerListFavorites];
        [detainSettingTableViewController setStringCellLabel:@"Settings are reset."];
         
    }
}

@end
