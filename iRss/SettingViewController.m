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
    arrayPoints = [NSArray arrayWithObjects:NSLocalizedString(@"ABOUT", nil), NSLocalizedString(@"REPORT_AN_ISSUE", nil), nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Delegate
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
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Table View Data Source
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

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetainSettingTableViewController *detainSettingTableViewController = [segue destinationViewController];
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    if ([indexPath section] == 0) {
        detainSettingTableViewController.stringCellLabel = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];
        detainSettingTableViewController.stringTitleForFooterSection = @"This version of the program.";
    }
    else {
        nil;
    }
}

@end
