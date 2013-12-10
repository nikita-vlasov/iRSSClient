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
    
    UIBarButtonItem *refresh =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                                                            target:self
                                                                            action:@selector(buttonBarRefreshPage:)];
    
    UIBarButtonItem *forward =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward
                                                                            target:self
                                                                            action:@selector(buttonBarForwardPage:)];
    
    UIBarButtonItem *back =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRewind
                                                                         target:self
                                                                         action:@selector(buttonBarBackPage:)];
    
    UIBarButtonItem *stop =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                         target:self
                                                                         action:@selector(buttonBarStopPage:)];
    self.navigationItem.rightBarButtonItems = @[refresh, forward, back, stop];
    
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
    [self.navigationController.navigationBar addSubview:progressView];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [progressView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action Bar Button
- (IBAction)buttonBarRefreshPage:(id)sender {
    [[self webView] reload];
}

- (IBAction)buttonBarForwardPage:(id)sender {
    [[self webView] goForward];
}

- (IBAction)buttonBarBackPage:(id)sender {
    [[self webView] goBack];
}

- (IBAction)buttonBarStopPage:(id)sender {
    [[self webView] stopLoading];
}

#pragma mark -
- (void)reloadData {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[self link]];
    [[self webView] loadRequest:request];
    self.webView.scalesPageToFit = YES;
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress {
    [progressView setProgress:progress animated:YES];
//    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

@end
