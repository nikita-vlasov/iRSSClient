#import "OfflineTableViewController.h"

@interface OfflineTableViewController () {
    
}

@end


@implementation OfflineTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self editButtonItem];
    [[self navigationItem] setTitle:NSLocalizedString(@"FAVORITES", nil)];
    
    UIBarButtonItem *newBackButton= [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    buttonDeleteAll = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                    target:self
                                                                    action:@selector(buttonDeleteAllRecords:)];
    barButtonDone = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                    target:self
                                                                    action:@selector(barButtonDone:)];
    self.navigationItem.rightBarButtonItem = barButtonDone;
    [[self tableView] reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

#pragma mark - Action
- (void)barButtonDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)buttonDeleteAllRecords:(id)sender {
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault boolForKey:@"SWITCH_WARNING_BOOL"] == NO) {
        [ResetSettingToDefault cleanerListFavorites];
        [[self tableView] reloadData];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"WARNING", nil)
                                                            message:NSLocalizedString(@"DELETE_AFF_FAVORITES", nil)
                                                           delegate:self
                                                  cancelButtonTitle:NSLocalizedString(@"DELETE", nil)
                                                  otherButtonTitles:NSLocalizedString(@"CANCEL", nil), nil];
        [alertView show];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            [ResetSettingToDefault cleanerListFavorites];
            [[self tableView] reloadData];
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - Editing Bar Button
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:YES];
    if (editing) {
        self.navigationItem.rightBarButtonItem = buttonDeleteAll;
    }
    else {
        self.navigationItem.rightBarButtonItem = barButtonDone;
    }
}

#pragma mark - SQL Query
- (NSArray *)arrayDataRssOffline {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM offline ORDER BY date_added DESC"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self arrayDataRssOffline] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *dictionaryOfflineNews = [[self arrayDataRssOffline] objectAtIndex:[indexPath row]];
    
    [[cell textLabel] setText:[dictionaryOfflineNews objectForKey:@"title"]];
    [[cell detailTextLabel] setText:[dictionaryOfflineNews objectForKey:@"date_added"]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *dictionaryOfflineNews = [[self arrayDataRssOffline] objectAtIndex:[indexPath row]];
        NSString *offlineNewsID = [dictionaryOfflineNews objectForKey:@"id"];
        NSString *queryString = [[NSString alloc] initWithFormat:@"DELETE FROM offline WHERE id = '%@'", offlineNewsID];
        
        [SQLiteAccess deleteWithSQL:queryString];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    
    if (indexPath) {
        NSDictionary *dictionary = [[self arrayDataRssOffline] objectAtIndex:[indexPath row]];
        DetailViewController *detailViewController = [segue destinationViewController];
        [detailViewController setStringOfflineKey:@"Offline"];
        [detailViewController setDetailItemOffline:dictionary];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
