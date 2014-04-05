#import "ChannelController.h"
#import "ChannelView.h"
#import "Channel.h"
#import "DataModel.h"
#import "RssFeedController.h"
#import "EditChannelController.h"

@interface ChannelController () <UITableViewDataSource, UITableViewDelegate> {
    @private
    NSManagedObjectContext *managedObjectContext;
    
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
    [[self navigationItem] setLeftBarButtonItem:[self editButtonItem]];

    channel = [[Channel alloc] init];
    arrayChannel = [[NSMutableArray alloc] init];

    managedObjectContext = [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];

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

#pragma mark - UIViewControllerEditing
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];

    if (editing) [[_channelView tableView] setEditing:YES animated:YES];
    else [[_channelView tableView] setEditing:NO animated:YES];
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
    [self performSegueWithIdentifier:@"OpenNewChannel" sender:nil];
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

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObject *managedObject= [arrayChannel objectAtIndex:[indexPath row]];
        [managedObjectContext deleteObject:managedObject];

        NSError *error = nil;
        [managedObjectContext save:&error];

        if (!error) {
            [arrayChannel removeObjectAtIndex:[indexPath row]];
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    channel = [arrayChannel objectAtIndex:[indexPath row]];

    [self performSegueWithIdentifier:@"OpenRssFeed" sender:nil];
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellAccessoryDisclosureIndicator) {
        channel = [arrayChannel objectAtIndex:[indexPath row]];

        [self performSegueWithIdentifier:@"OpenEditChannel" sender:self];
    }
}

- (void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:YES];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [self setEditing:NO];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"OpenNewChannel"]) {}
    else if ([[segue identifier] isEqualToString:@"OpenEditChannel"]) {
        EditChannelController *editChannelController = [segue destinationViewController];
        [editChannelController setChannel:channel];
    }
    else if ([[segue identifier] isEqualToString:@"OpenRssFeed"]) {
        RssFeedController *rssFeedController = [segue destinationViewController];
        [rssFeedController setLinkRssChannel:[channel valueForKey:@"link"]];
    }
}

@end
