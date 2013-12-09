#import "TableViewController.h"

@interface TableViewController () {
    
}

@end


@implementation TableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arrayDataRss = [[NSArray alloc] init];
    
    self.navigationItem.title = NSLocalizedString(@"TITLE_NEWS_ONLINE", nil);
    [self buttonBarRefresh:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action
- (IBAction)buttonBarRefresh:(id)sender {
    if ([Internet internetConnection] == YES) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [self retrievingData];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERROR", nil)
                                                            message:NSLocalizedString(@"ERROR_INTERNET_CONNECTION", nil)
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}

#pragma mark -
- (void)retrievingData {
    NSURL *url = [NSURL URLWithString:_linkToTheRssFeeds];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    
    [RSSParser parseRSSFeedForRequest:request success:^(NSArray *feedItems) {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        arrayDataRss = feedItems;
        NSString *stringTitle = [NSString stringWithFormat:@"News (%lu)", (unsigned long)[arrayDataRss count]];
        self.navigationItem.title = stringTitle;
        [[self tableView] reloadData];
    }failure:^(NSError *error) {
        NSLog(@"Error Get Data! %@", error);
    }];
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayDataRss count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    RSSItem *item = [arrayDataRss objectAtIndex:indexPath.row];
    cell.textLabel.text = [item title];
    cell.detailTextLabel.text = [item pubDates];
    
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    if (indexPath) {
        RSSItem *item = [arrayDataRss objectAtIndex:indexPath.row];
        [segue.destinationViewController setDetailItem:item];
    }
}

@end
