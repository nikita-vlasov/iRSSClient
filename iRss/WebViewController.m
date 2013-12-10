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
    
    [self reloadData];
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

@end
