#import "DetailItemController.h"
#import "DetailItemView.h"

@interface DetailItemController ()

/** View. */
@property (strong, nonatomic) IBOutlet DetailItemView *detailItemView;

@end


@implementation DetailItemController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@", [self rssItems]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end