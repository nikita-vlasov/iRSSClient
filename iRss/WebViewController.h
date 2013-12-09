#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController {
    
}

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UIWebView *webView;

#pragma mark -
@property (strong, nonatomic) NSURL *link;

@end
