#import "WebViewController.h"

@interface WebViewController () {
    
}

@end


@implementation WebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reloadData {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[self link]];
    [[self webView] loadRequest:request];
    self.webView.scalesPageToFit = YES;
}

@end
