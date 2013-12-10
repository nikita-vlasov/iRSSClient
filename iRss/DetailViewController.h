#import <UIKit/UIKit.h>
#import <Social/Social.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "RSSParser.h"
#import "WebViewController.h"
#import "SQLiteAccess.h"
#import "Internet.h"

@interface DetailViewController : UIViewController <UIActionSheetDelegate, MFMailComposeViewControllerDelegate> {
    @private
    NSString *stringTitle;
    NSString *stringItemDescription;
    NSString *stringPubDate;
    NSURL *urlLink;
    
    NSInteger fontSize;
    
    SLComposeViewController *slComposeViewController;
    MFMailComposeViewController *mfMailComposeViewController;
}

#pragma mark - Bar Button
- (IBAction)buttonBarAction:(id)sender;

#pragma mark - Action
- (IBAction)buttonAddNewsToOffline:(id)sender;
- (IBAction)buttonFondSizeAdd:(id)sender;
- (IBAction)buttonFondSizeTake:(id)sender;

#pragma mark - Outlet Bar Button
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonBarActionOutlet;

#pragma mark - Outlet Button
@property (weak, nonatomic) IBOutlet UIButton *buttonAddNewsToOfflineOutlet;

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;

#pragma mark - Online
@property (nonatomic, strong) RSSItem *detailItem;

#pragma mark - Offline
@property (strong, nonatomic) NSDictionary *detailItemOffline;
@property (strong, nonatomic) NSString *stringOfflineKey;

@end
