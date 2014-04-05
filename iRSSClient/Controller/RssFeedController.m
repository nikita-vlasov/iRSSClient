#import "RssFeedController.h"
#import "RssFeedView.h"
#import "RSSParser.h"
#import "DetailItemController.h"

@interface RssFeedController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate> {
    @private
    RSSItem *rssItems;
    NSArray *arrayRssFeed;
    NSArray *arrayRssFeedFiltered;

    BOOL isSearch;
}

/** View */
@property (strong, nonatomic) IBOutlet RssFeedView *rssFeedView;

@end


@implementation RssFeedController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationItem] setTitle:NSLocalizedString(@"RSS Feed", nil)];
    [[_rssFeedView tableView] setContentOffset:CGPointMake(0, 44)];
    [[_rssFeedView refreshControl] addTarget:self action:@selector(startRefresh) forControlEvents:UIControlEventValueChanged];
    [[_rssFeedView tableView] addSubview:[_rssFeedView refreshControl]];

    rssItems = [[RSSItem alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self startRefresh];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 
- (void)startRefresh {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [self loadRssFeed];
}

- (void)stopRefresh {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [[_rssFeedView refreshControl] endRefreshing];
}

- (void)loadRssFeed {
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[self linkRssChannel]]];
    [RSSParser parseRSSFeedForRequest:urlRequest success:^(NSArray *feedItems) {
        arrayRssFeed = feedItems;
        [[_rssFeedView tableView] reloadData];
        [self stopRefresh];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
        [self stopRefresh];
    }];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[_rssFeedView searchBar] resignFirstResponder];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title contains[cd] %@", searchText];
    arrayRssFeedFiltered = [arrayRssFeed filteredArrayUsingPredicate:predicate];

    if (![searchText length] == 0) isSearch = YES;
    else isSearch = NO;

    [[_rssFeedView tableView] reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearch == YES) return [arrayRssFeedFiltered count];
    else return [arrayRssFeed count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *subtitleCell = [tableView dequeueReusableCellWithIdentifier:@"SubtitleCell"];

    if (isSearch == YES) rssItems = [arrayRssFeedFiltered objectAtIndex:[indexPath row]];
    else rssItems = [arrayRssFeed objectAtIndex:[indexPath row]];

    [[subtitleCell textLabel] setText:[rssItems title]];
    [[subtitleCell detailTextLabel] setText:[rssItems itemDescription]];

    return subtitleCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (isSearch == YES) rssItems = [arrayRssFeedFiltered objectAtIndex:[indexPath row]];
    else rssItems = [arrayRssFeed objectAtIndex:[indexPath row]];

    [self performSegueWithIdentifier:@"OpenDetailItems" sender:nil];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"OpenDetailItems"]) {
        DetailItemController *detailItemController = [segue destinationViewController];
        [detailItemController setRssItems:rssItems];
    }
}

@end
