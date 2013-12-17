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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - SQL
- (NSArray *)arrayGetAllRssChannel {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM add_rss"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self arrayGetAllRssChannel] count];
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
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

@end
