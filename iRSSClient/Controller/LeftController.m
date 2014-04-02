#import "LeftController.h"
#import "LeftView.h"

@interface LeftController ()

@property (strong, nonatomic) IBOutlet LeftView *leftView;

@end


@implementation LeftController

#pragma mark - UIViewCOntroller
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
