#import "SelectionTableViewController.h"

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
    self.navigationItem.title = NSLocalizedString(@"APPLE_ALL_RSS", nil);
    
    arrayTopic = [NSArray arrayWithObjects:
                  @"Hot News",
                  @"Apple Developer News",
                  @"Mac Desktop Computers",
                  @"Mac OS X",
                  @"iPhone",
                  @"iPod",
                  nil];
    
    arrayDescription = [NSArray arrayWithObjects:
                        @"Hot News provided by Apple.",
                        @"Apple Developer News feed provided by Apple, Inc.",
                        @"Apple - Support - Most Recent - Apple Inc.",
                        @"Apple - Support - Most Recent - Mac OS.",
                        @"Apple - Support - Most Recent - iPhone",
                        @"Apple - Support - Most Recent - iPod",
                        nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [arrayTopic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.textLabel.text = [arrayTopic objectAtIndex:indexPath.section];
    
    return cell;
}

#pragma mark - Table View Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [arrayDescription objectAtIndex:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TableViewController *tableViewController = segue.destinationViewController;
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];

    if ([indexPath section] == 0) {
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
}

@end
