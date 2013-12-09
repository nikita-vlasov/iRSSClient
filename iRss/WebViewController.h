#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController {
    
}

#pragma mark - Action Bar Button
- (IBAction)buttonBarRefreshPage:(id)sender;
- (IBAction)buttonBarForwardPage:(id)sender;
- (IBAction)buttonBarBackPage:(id)sender;
- (IBAction)buttonBarStopPage:(id)sender;

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UIWebView *webView;

#pragma mark -
@property (strong, nonatomic) NSURL *link;

@end
