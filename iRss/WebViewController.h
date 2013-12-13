#import <UIKit/UIKit.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface WebViewController : UIViewController <UIWebViewDelegate, NJKWebViewProgressDelegate> {
    @private
    NJKWebViewProgressView *progressView;
    NJKWebViewProgress *progressProxy;
}

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UIWebView *webView;

#pragma mark -
@property (strong, nonatomic) NSURL *link;

@end
