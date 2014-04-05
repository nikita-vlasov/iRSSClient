#import "SettingController.h"
#import "SettingView.h"

@interface SettingController () <UITableViewDataSource, UITableViewDelegate>

/** View */
@property (strong, nonatomic) IBOutlet SettingView *SettingView;

@end


@implementation SettingController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationItem] setTitle:NSLocalizedString(@"Setting", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *ringDetailCell = [tableView dequeueReusableCellWithIdentifier:@"RingDetailCell"];
    return ringDetailCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
