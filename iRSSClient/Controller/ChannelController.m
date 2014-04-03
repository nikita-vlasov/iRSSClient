#import "ChannelController.h"
#import "ChannelView.h"
#import "Channel.h"
#import "DataModel.h"
#import "RssFeedController.h"

@interface ChannelController () <UITableViewDataSource, UITableViewDelegate> {
    @private
    Channel *channel;
    NSMutableArray *arrayChannel;
}

#pragma mark - UIView
@property (strong, nonatomic) IBOutlet ChannelView *channelView;

@end


@implementation ChannelController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationItem] setTitle:NSLocalizedString(@"Channel", nil)];

    channel = [[Channel alloc] init];
    arrayChannel = [[NSMutableArray alloc] init];

    _channelView.barButtonOpenChannel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(opneChannel:)];
    [[self navigationItem] setRightBarButtonItem:[[self channelView] barButtonOpenChannel]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self loadChannelList];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 
- (void)loadChannelList {
    [arrayChannel removeAllObjects];
    for (channel in [[DataModel sharedModel] entityDataSetEnturyName:@"Channel"]) {
        [arrayChannel addObject:channel];
    }
    [[_channelView tableView] reloadData];
}

#pragma mark - UIBarButtonItem
- (void)opneChannel:(UIBarButtonItem *)sender {
    [self performSegueWithIdentifier:@"OpenEditChannel" sender:nil];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayChannel count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *rindDetailCell = [tableView dequeueReusableCellWithIdentifier:@"RingDetailCell"];
    channel = [arrayChannel objectAtIndex:[indexPath row]];

    [[rindDetailCell textLabel] setText:[channel valueForKey:@"title"]];
    [[rindDetailCell detailTextLabel] setText:@"1"];

    return rindDetailCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    channel = [arrayChannel objectAtIndex:[indexPath row]];
    [self performSegueWithIdentifier:@"OpenRssFeed" sender:nil];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"OpenEditChannel"]) {}
    else if ([[segue identifier] isEqualToString:@"OpenRssFeed"]) {
        RssFeedController *rssFeedController = [segue destinationViewController];
        [rssFeedController setLinkRssChannel:[channel valueForKey:@"link"]];
    }
}

@end
