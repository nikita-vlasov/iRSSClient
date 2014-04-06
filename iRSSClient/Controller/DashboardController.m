#import "DashboardController.h"
#import "DashboardView.h"

@interface DashboardController ()

/** View. */
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
