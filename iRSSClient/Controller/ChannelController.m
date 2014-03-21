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

    [[[self channelView] leftBarButton] setAction:@selector(openFavorites:)];
    [[[self channelView] rightBarButton] setAction:@selector(openSetting:)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIBarButtonItem
- (void)openSetting:(UIBarButtonItem *)sender {
}

- (void)openFavorites:(UIBarButtonItem *)sender {
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *basicCell = [[[self channelView] tableView] dequeueReusableCellWithIdentifier:@"BasicCell"];

    return basicCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
