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
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.title = NSLocalizedString(@"FAVORITES", nil);
    [[self tableView] reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

#pragma mark - SQL Query
- (NSArray *)arrayDataRssOffline {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM offline"];
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self arrayDataRssOffline] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    NSDictionary *dictionaryOfflineNews = [[self arrayDataRssOffline] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [dictionaryOfflineNews objectForKey:@"title"];
    cell.detailTextLabel.text = [dictionaryOfflineNews objectForKey:@"pub_date"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *dictionaryOfflineNews = [[self arrayDataRssOffline] objectAtIndex:indexPath.row];
        NSString *offlineNewsID = [dictionaryOfflineNews objectForKey:@"id"];
        NSString *queryString = [[NSString alloc] initWithFormat:@"DELETE FROM offline WHERE id = '%@'", offlineNewsID];
        
        [SQLiteAccess deleteWithSQL:queryString];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    
    if (indexPath) {
        NSDictionary *dictionary = [[self arrayDataRssOffline] objectAtIndex:indexPath.row];
        DetailViewController *detailViewController = segue.destinationViewController;
//        detailViewController.detailItemOffline = dictionary;
        [detailViewController setDetailItemOffline:dictionary];
//        detailViewController.stringOfflineKey = @"Offline";
        [detailViewController setStringOfflineKey:@"Offline"];
        
        
//        [[segue destinationViewController] setDetailItemOffline:dictionary];
    }
}

@end
