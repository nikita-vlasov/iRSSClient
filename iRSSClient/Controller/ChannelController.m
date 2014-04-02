#import "ChannelController.h"
#import "ChannelView.h"

@interface ChannelController () <UITableViewDataSource, UITableViewDelegate> {
    @private
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

    arrayChannel = [[NSMutableArray alloc] init];

    _channelView.barButtonOpenChannel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(opneChannel:)];
    [[self navigationItem] setRightBarButtonItem:[[self channelView] barButtonOpenChannel]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
    UITableViewCell *basicCell = [[[self channelView] tableView] dequeueReusableCellWithIdentifier:@"BasicCell"];

    return basicCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    [self performSegueWithIdentifier:@"OpenRssFeed" sender:nil];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"OpenEditChannel"]) {}
    else if ([[segue identifier] isEqualToString:@"OpenRssFeed"]) {}
}

@end
