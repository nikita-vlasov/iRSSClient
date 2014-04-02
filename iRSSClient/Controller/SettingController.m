#import "SettingController.h"
#import "SettingView.h"

@interface SettingController ()

/** View */
@property (strong, nonatomic) IBOutlet SettingView *SettingView;

@end


@implementation SettingController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
