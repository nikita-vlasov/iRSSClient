#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "RSSParser.h"
#import "WebViewController.h"
#import "SQLiteAccess.h"
#import "Internet.h"
#import "OneTextView.h"

@interface DetailViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    @private
    UIBarButtonItem *barButtonAaction;
    UIBarButtonItem *barButtonShare;
    
    NSString *stringTitle;
    NSString *stringItemDescription;
    NSString *stringPubDate;
    NSURL *urlLink;
    
    NSInteger fontSize;
    
    SLComposeViewController *slComposeViewController;
    MFMailComposeViewController *mfMailComposeViewController;
}

#pragma mark - Action
- (IBAction)buttonAddNewsToOffline:(id)sender;
- (IBAction)buttonFondSizeAdd:(id)sender;
- (IBAction)buttonFondSizeTake:(id)sender;

#pragma mark - Outlet Button
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonAddNewsToOfflineOutlet;

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;

#pragma mark - Online
@property (strong, nonatomic) RSSItem *detailItem;

#pragma mark - Offline
@property (strong, nonatomic) NSDictionary *detailItemOffline;
@property (strong, nonatomic) NSString *stringOfflineKey;

@end
