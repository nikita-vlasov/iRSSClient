#import "LeftController.h"
#import "LeftView.h"
#import "UIViewController+MMDrawerController.h"
#import "DrawerFactory.h"

@interface LeftController () <UITableViewDataSource, UITableViewDelegate> {
    @private
    NSMutableArray *arrayTitle;
}

/** View */
@property (strong, nonatomic) IBOutlet LeftView *leftView;

@end


@implementation LeftController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    arrayTitle = [[NSMutableArray alloc] init];

    [arrayTitle addObject:@{@"title" : NSLocalizedString(@"Dashboard", nil), @"icon" : @""}];
    [arrayTitle addObject:@{@"title" : NSLocalizedString(@"Channel", nil), @"icon" : @""}];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *ringDetailCell = [tableView dequeueReusableCellWithIdentifier:@"RingDetailCell"];

    [[ringDetailCell textLabel] setText:[[arrayTitle objectAtIndex:[indexPath row]] valueForKey:@"title"]];
    [[ringDetailCell detailTextLabel] setText:@""];

    return ringDetailCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self openControllers:[indexPath row]];
}

/** Метод, дает возможность открыть необходимы контролер по индексу ячейки. */
- (void)openControllers:(int)index {
    if (index == 0) {
        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] dashboardController] withCloseAnimation:YES completion:nil];
    }
    else if (index == 1) {
        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] channelController] withCloseAnimation:YES completion:nil];
    }
//    else if (index == 1) {
//        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] customersController] withCloseAnimation:YES completion:nil];
//    }
//    else if (index == 2) {
//        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] vendorsController] withCloseAnimation:YES completion:nil];
//    }
//    else if (index == 3) {
//        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] historyController] withCloseAnimation:YES completion:nil];
//    }
//    else if (index == 4) {
//        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] settingController] withCloseAnimation:YES completion:nil];
//    }
}

@end
