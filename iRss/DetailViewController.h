#import <UIKit/UIKit.h>
#import "RSSParser.h"

@interface DetailViewController : UIViewController <UIActionSheetDelegate> {
    @private
    SLComposeViewController *slComposeViewController;
}

#pragma mark - Action
- (IBAction)buttonBarAction:(id)sender;
- (IBAction)buttonAddNewsToOffline:(id)sender;
- (IBAction)buttonShareFacebook:(id)sender;
- (IBAction)buttonShareTwitter:(id)sender;
- (IBAction)buttonSendEmail:(id)sender;

#pragma mark - Outlet Button
@property (weak, nonatomic) IBOutlet UIBarButtonItem *buttonBarActionOutlet;
@property (weak, nonatomic) IBOutlet UIButton *buttonAddNewsToOfflineOutlet;
@property (weak, nonatomic) IBOutlet UIButton *buttonShareFacebookOutlet;
@property (weak, nonatomic) IBOutlet UIButton *buttonShareTwitterOutlet;
@property (weak, nonatomic) IBOutlet UIButton *buttonSendEmailOutlet;

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UITextView *textViewContent;

#pragma mark - Online
@property (nonatomic, strong) RSSItem *detail;

#pragma mark - Offline
@property (strong, nonatomic) NSDictionary *detailItemOffline;
@property (strong, nonatomic) NSString *stringOfflineKey;

@end
