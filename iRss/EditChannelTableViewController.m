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
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

#pragma mark - Action
- (IBAction)buttonBarSave:(id)sender {
    [[self tableView] reloadData];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                        message:NSLocalizedString(@"SAVE_EDITING", nil)
                                                       delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"CANCEL", nil)
                                              otherButtonTitles:NSLocalizedString(@"SAVE", nil), nil];
    [alertView show];
}

#pragma mark -
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1: {
            if ([[self stringAddKey] isEqualToString:@"ADD_CHANNEL"]) {
                [self addNewRssChannel];
            }
            else {
                [self saveEditing];
            }
            [[self navigationController] popViewControllerAnimated:YES];
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - SQL Query
- (void)saveEditing {
    NSString *rssChanelID = [[self dictionaryRssChannel] objectForKey:@"id_rss_chanel"];
    NSString *queryString = [[NSString alloc] initWithFormat:@"UPDATE add_rss SET title = '%@', link = '%@' WHERE id_rss_chanel = '%@'", stringTitle, stringLink, rssChanelID];
    [SQLiteAccess updateWithSQL:queryString];
}

- (void)addNewRssChannel {
    [Client addNewChannelSetTitle:stringTitle setLink:stringLink];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCellEditChannel *cell = [tableView dequeueReusableCellWithIdentifier:@"CellEditChannel"];
    
    if ([indexPath row] == 0) {
        [[cell imageViewCell] setImage:[UIImage imageNamed:@"header.png"]];
        [[cell textFieldCellEdit] setPlaceholder:NSLocalizedString(@"TITLE", nil)];
        if ([[[cell textFieldCellEdit] text] isEqualToString:@""]) {
            [[cell textFieldCellEdit] setText:[[self dictionaryRssChannel] objectForKey:@"title"]];
        }
        stringTitle = [[cell textFieldCellEdit] text];
        return cell;
    }
    if ([indexPath row] == 1) {
        [[cell imageViewCell] setImage:[UIImage imageNamed:@"link.png"]];
        [[cell textFieldCellEdit] setPlaceholder:NSLocalizedString(@"LINK", nil)];
        if ([[[cell textFieldCellEdit] text] isEqualToString:@""]) {
            [[cell textFieldCellEdit] setText:[[self dictionaryRssChannel] objectForKey:@"link"]];
        }
        stringLink = [[cell textFieldCellEdit] text];
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

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSUserDefaults *userDefoults = [NSUserDefaults standardUserDefaults];
    if ([userDefoults boolForKey:@"SWITCH_TIPS_BOOL"] == YES) {
        return NSLocalizedString(@"DESCRIPTION_TABLE_TITLE", nil);
    }
    else {
        return nil;
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
