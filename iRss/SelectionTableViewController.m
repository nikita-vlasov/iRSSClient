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
    arrayTopic = [NSArray arrayWithObjects:@"Hot News", @"Apple Developer News", nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [arrayTopic count];
}

/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    retutn @"Имя секции";
}
 */

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

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TableViewController *tableViewController = segue.destinationViewController;
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    
    if ([indexPath section] == 0) {
        tableViewController.linkToTheRssFeeds = @"http://images.apple.com/main/rss/hotnews/hotnews.rss";
    }
    
    if ([indexPath section] == 1) {
        tableViewController.linkToTheRssFeeds = @"https://developer.apple.com/news/rss/news.rss";
    }
}

@end
