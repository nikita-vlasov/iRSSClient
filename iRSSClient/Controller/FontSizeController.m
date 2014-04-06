#import "FontSizeController.h"
#import "FontSizeView.h"

@interface FontSizeController ()

/** View. */
@property (strong, nonatomic) IBOutlet FontSizeView *fontSizeView;

@end


@implementation FontSizeController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
