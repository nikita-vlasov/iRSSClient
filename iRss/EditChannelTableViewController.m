#import "EditChannelTableViewController.h"

@interface EditChannelTableViewController () {
    
}

@end


@implementation EditChannelTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action
- (IBAction)buttonBarSave:(id)sender {
    [[self tableView] reloadData];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Точно" message:@"weqwe" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Save", nil];
    [alertView show];
}

#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1: {
            [self saveEditing];
            [[self navigationController] popViewControllerAnimated:YES];
            break;
        }
        default: {
            break;
        }
    }
}

- (void)saveEditing {
    NSString *rssChanelID = [[self dictionaryRssChannel] objectForKey:@"id_rss_chanel"];
    NSString *queryString = [[NSString alloc] initWithFormat:@"UPDATE add_rss SET title = '%@', link = '%@', description = '%@' WHERE id_rss_chanel = '%@'",
                             stringTitle,
                             stringLink,
                             stringDescription,
                             rssChanelID];
    [SQLiteAccess updateWithSQL:queryString];
}


#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCellEditChannel *cell = [tableView dequeueReusableCellWithIdentifier:@"CellEditChannel"];
    
    if ([indexPath row] == 0) {
        [[cell labelCellEdit] setText:NSLocalizedString(@"TITLE", nil)];
        if ([[[cell textFieldCellEdit] text] isEqualToString:@""]) {
            [[cell textFieldCellEdit] setText:[[self dictionaryRssChannel] objectForKey:@"title"]];
        }
        stringTitle = [[cell textFieldCellEdit] text];
        return cell;
    }
    if ([indexPath row] == 1) {
        [[cell labelCellEdit] setText:NSLocalizedString(@"LINK", nil)];
        if ([[[cell textFieldCellEdit] text] isEqualToString:@""]) {
            [[cell textFieldCellEdit] setText:[[self dictionaryRssChannel] objectForKey:@"link"]];
        }
        stringLink = [[cell textFieldCellEdit] text];
        return cell;
    }
    if ([indexPath row] == 2) {
        [[cell labelCellEdit] setText:NSLocalizedString(@"DESCRIPTION", nil)];
        if ([[[cell textFieldCellEdit] text] isEqualToString:@""]) {
            [[cell textFieldCellEdit] setText:[[self dictionaryRssChannel] objectForKey:@"description"]];
        }
        stringDescription = [[cell textFieldCellEdit] text];
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

@end
