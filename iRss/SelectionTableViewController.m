#import "SelectionTableViewController.h"
#import "AddNewRssViewController.h"

@interface SelectionTableViewController () {
    
}

@end


@implementation SelectionTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.title = NSLocalizedString(@"APPLE_ALL_RSS", nil);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

#pragma mark SQL
- (NSArray *)arrayGetRssChanel {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM add_rss"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self arrayGetRssChanel] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *dictionary = [[self arrayGetRssChanel] objectAtIndex:indexPath.section];
    cell.textLabel.text = [dictionary objectForKey:@"title"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *dictionary = [[self arrayGetRssChanel] objectAtIndex:indexPath.section];
        NSLog(@"%@", dictionary);
        NSString *addRssID = [dictionary objectForKey:@"id_rss_chanel"];
        NSString *queryString = [[NSString alloc] initWithFormat:@"DELETE FROM add_rss WHERE id_rss_chanel = '%@'", addRssID];

        
        
        [SQLiteAccess deleteWithSQL:queryString];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
//        [[self tableView] reloadData];
//        [[self tableView] deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        [[self tableView] deleteSections:[indexPath] withRowAnimation:UITableViewRowAnimationFade];
  //      [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
       // [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSDictionary *dictionary = [[self arrayGetRssChanel] objectAtIndex:section];
    return [dictionary objectForKey:@"description"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

/*
 NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
 
 if (indexPath) {
 NSDictionary *dictionary = [[self arrayDataRssOffline] objectAtIndex:indexPath.row];
 DetailViewController *detailViewController = segue.destinationViewController;
 [detailViewController setDetailItemOffline:dictionary];
 [detailViewController setStringOfflineKey:@"Offline"];
 }
 */

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    
    if (indexPath) {
        TableViewController *tableViewController = segue.destinationViewController;
        NSDictionary *dictionary = [[self arrayGetRssChanel] objectAtIndex:indexPath.section];
        NSString *stringLink = [dictionary objectForKey:@"link"];
        [tableViewController setLinkToTheRssFeeds:stringLink];
        
        
        //TableViewController *tableViewController = segue.destinationViewController;
        //[tableViewController setLinkToTheRssFeeds:dictionary];
    }
    
    
    /*
    TableViewController *tableViewController = segue.destinationViewController;
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];

    if ([indexPath section] == 32) {
        [tableViewController setLinkToTheRssFeeds:@"http://images.apple.com/main/rss/hotnews/hotnews.rss"];
    }
    else if ([indexPath section] == 1) {
        [tableViewController setLinkToTheRssFeeds:@"https://developer.apple.com/news/rss/news.rss"];
    }
    else if ([indexPath section] == 2) {
        [tableViewController setLinkToTheRssFeeds:@"http://rss.support.apple.com/desktopcomputers"];
    }
    else if ([indexPath section] == 3) {
        [tableViewController setLinkToTheRssFeeds:@"http://rss.support.apple.com/macos"];
    }
    else if ([indexPath section] == 4) {
        [tableViewController setLinkToTheRssFeeds:@"http://rss.support.apple.com/iphone"];
    }
    else if ([indexPath section] == 5) {
        [tableViewController setLinkToTheRssFeeds:@"http://rss.support.apple.com/ipod"];
    }
    else {
        [self performSegueWithIdentifier:@"OpenAddRssChanel" sender:self];
    }
    
    AddNewRssViewController *addNewRssViewController = segue.destinationViewController;
     */
    
}

- (IBAction)buttonAddNewRssChanel:(id)sender {
    [self performSegueWithIdentifier:@"OpenAddRssChanel" sender:self];
}
@end
