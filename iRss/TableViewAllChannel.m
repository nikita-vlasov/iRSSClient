#import "TableViewAllChannel.h"

@interface TableViewAllChannel () {
    
}

@end


@implementation TableViewAllChannel

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [self editButtonItem];
    
    [[self tableView] reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

#pragma mark - UIViewControllerEditing
- (void)setEditing:(BOOL)flag animated:(BOOL)animated {
    [super setEditing:flag animated:animated];
    
    if (flag == YES) {
            [[self tableView] setEditing:YES animated:YES];
    }
    else {
            [[self tableView] setEditing:NO animated:YES];
    }
}

#pragma mark - SQL Query
- (NSArray *)arrayGetAllRssChannel {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM add_rss"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return [[self arrayGetAllRssChannel] count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *channelCell = [tableView dequeueReusableCellWithIdentifier:@"ChannelCell"];
    NSDictionary *dictionary = [[self arrayGetAllRssChannel] objectAtIndex:[indexPath row]];
    if (channelCell) {
        if ([indexPath section] == 0) {
            [[channelCell textLabel] setText:[dictionary objectForKey:@"title"]];
            return channelCell;
        }
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([indexPath section] == 0) {
            NSDictionary *dictionary = [[self arrayGetAllRssChannel] objectAtIndex:[indexPath row]];
            NSString *addRssID = [dictionary objectForKey:@"id_rss_chanel"];
            NSString *queryString = [[NSString alloc] initWithFormat:@"DELETE FROM add_rss WHERE id_rss_chanel = '%@'", addRssID];
            
            [SQLiteAccess deleteWithSQL:queryString];
        }
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30.0f;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return @"Channel";
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:YES];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:NO];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"OpenRssChannel"]) {
        NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
        if (indexPath) {
            TableViewController *tableViewController = [segue destinationViewController];
            NSDictionary *dictionary = [[self arrayGetAllRssChannel] objectAtIndex:[indexPath row]];
            NSString *stringUrlLink = [dictionary objectForKey:@"link"];
            [tableViewController setLinkToTheRssFeeds:stringUrlLink];
        }
    }
    if ([[segue identifier] isEqualToString:@""]) {
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
