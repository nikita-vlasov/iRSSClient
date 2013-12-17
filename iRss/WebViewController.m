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
    
    progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = progressProxy;
    progressProxy.webViewProxyDelegate = self;
    progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.5f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    
    [self reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[[self navigationController] navigationBar] addSubview:progressView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [progressView removeFromSuperview];
}

#pragma mark - Action Toolbar Button
- (IBAction)buttonToolbarBack:(id)sender {
    [[self webView] goBack];
}

- (IBAction)buttonToolbarForward:(id)sender {
    [[self webView] goForward];
}

- (IBAction)buttonToolbarStop:(id)sender {
    [[self webView] stopLoading];
}

- (IBAction)buttonToolbarRefresh:(id)sender {
    [[self webView] reload];
}

#pragma mark -
- (void)reloadData {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[self link]];
    [[self webView] loadRequest:request];
    [[self webView] setScalesPageToFit:YES];
}

#pragma mark - NJKWebViewProgressDelegate
- (void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    [progressView setProgress:progress animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
