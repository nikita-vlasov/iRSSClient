#import "DashboardController.h"
#import "DashboardView.h"

#import "ChannelController.h"
#import "FPPopoverController.h"

@interface DashboardController ()

@property (strong, nonatomic) IBOutlet DashboardView *dashboardView;

@end


@implementation DashboardController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationItem] setTitle:NSLocalizedString(@"Dashboard", nil)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
