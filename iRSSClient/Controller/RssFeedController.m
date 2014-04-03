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

//    [[[self rssFeedView] refreshControl] addTarget:self action:@selector(startRefresh:) forControlEvents:UIControlEventAllEvents];
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
        NSLog(@"Получение RSS-потока: %@", feedItems);
        arrayRssFeed = feedItems;
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

    rssItems = [arrayRssFeed objectAtIndex:[indexPath row]];
    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
