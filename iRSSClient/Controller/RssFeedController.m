#import "RssFeedController.h"
#import "RssFeedView.h"
#import "RSSParser.h"

@interface RssFeedController () <UITableViewDataSource, UITableViewDelegate> {
    @private
    RSSItem *rssItems;
    NSArray *arrayRssFeed;
}

/** View */
@property (strong, nonatomic) IBOutlet RssFeedView *rssFeedView;

@end


@implementation RssFeedController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationItem] setTitle:NSLocalizedString(@"RSS Feed", nil)];

    rssItems = [[RSSItem alloc] init];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self loadRssFeed];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 
- (void)loadRssFeed {
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:[self linkRssChannel]]];
    [RSSParser parseRSSFeedForRequest:urlRequest success:^(NSArray *feedItems) {
        arrayRssFeed = feedItems;
        [[_rssFeedView tableView] reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:[error localizedDescription]];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayRssFeed count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *subtitleCell = [tableView dequeueReusableCellWithIdentifier:@"SubtitleCell"];

    rssItems = [arrayRssFeed objectAtIndex:[indexPath row]];

    [[subtitleCell textLabel] setText:[rssItems title]];
    [[subtitleCell detailTextLabel] setText:[rssItems itemDescription]];

    return subtitleCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    rssItems = [arrayRssFeed objectAtIndex:[indexPath row]];
    [self performSegueWithIdentifier:@"OpenDetailItems" sender:nil];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"OpenDetailItems"]) {
    }
}

@end
