#import "DetailItemController.h"
#import "DetailItemView.h"
#import "TextViewCell.h"
#import "NSDate+Date.h"
#import <Social/Social.h>
#import <MessageUI/MFMailComposeViewController.h>
#import <MessageUI/MessageUI.h>
#import "SVWebViewController.h"
#import "FPPopoverController.h"

@interface DetailItemController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, FPPopoverControllerDelegate> {
    @private
    UIBarButtonItem *barButtonShare;
    UIBarButtonItem *barButtonFontSize;

    /** Для отправки информации о коде через E-Mail. */
    MFMailComposeViewController *mfMailComposeViewController;
    /** Для отправки информации о коде через Message. */
    MFMessageComposeViewController *mfMessageComposeViewController;
    /** Шаринг в соц.сети. */
    SLComposeViewController *slComposeViewController;
    /** WebViewController */
    SVModalWebViewController *modalWebViewController;

    FPPopoverController *popoverController;
    UIViewController *viewController;

    float contentFontSize;
}

/** View. */
@property (strong, nonatomic) IBOutlet DetailItemView *detailItemView;

@end


@implementation DetailItemController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    barButtonShare = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                   target:self
                                                                   action:@selector(shareButton:)];

    barButtonFontSize = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_font_size.png"]
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(fontSizeButton:)];
    [[self navigationItem] setRightBarButtonItems:@[barButtonShare, barButtonFontSize]];

    [[[self detailItemView] actionSheetShare] addButtonWithTitle:NSLocalizedString(@"E-Mail", nil)];
    [[[self detailItemView] actionSheetShare] addButtonWithTitle:NSLocalizedString(@"Message", nil)];
    [[[self detailItemView] actionSheetShare] addButtonWithTitle:NSLocalizedString(@"Facebook", nil)];
    [[[self detailItemView] actionSheetShare] addButtonWithTitle:NSLocalizedString(@"Twitter", nil)];
    [[[self detailItemView] actionSheetShare] addButtonWithTitle:NSLocalizedString(@"Open Link", nil)];
    [[[self detailItemView] actionSheetShare] addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];

    [[[self detailItemView] actionSheetShare] setCancelButtonIndex:5];
    [[[self detailItemView] actionSheetShare] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    contentFontSize = [[NSUserDefaults standardUserDefaults] doubleForKey:@"content_font_size"];

    [self reloadData];
}

- (void)dealloc {
    mfMailComposeViewController = nil;
    slComposeViewController = nil;
    modalWebViewController = nil;
    popoverController = nil;
    viewController = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark -
- (void)reloadData {
    [[[self detailItemView] labelTitle] setText:[[self rssItems] title]];
    [[[self detailItemView] labelAuthor] setText:[[self rssItems] author]];
    [[[self detailItemView] labelDate] setText:[NSDate getFormattetDateSetDate:[[self rssItems] pubDate]]];
}

#pragma mark - UIBarButtonItem
- (void)shareButton:(UIBarButtonItem *)sender {
    [[[self detailItemView] actionSheetShare] showInView:[self detailItemView]];
}

- (void)fontSizeButton:(UIBarButtonItem *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];

    viewController = [storyboard instantiateViewControllerWithIdentifier:@"SelectFontSize"];
    popoverController = [[FPPopoverController alloc] initWithViewController:viewController];
//    [popoverController setContentSize:CGSizeMake(150.0f, 200.0f)];

    UIView *view = [sender valueForKey:@"view"];
    [popoverController presentPopoverFromView:view];

    [popoverController setDelegate:self];
}

#pragma mark - FPPopoverControllerDelegate
- (void)popoverControllerDidDismissPopover:(FPPopoverController *)popoverController {
    contentFontSize = [[NSUserDefaults standardUserDefaults] doubleForKey:@"content_font_size"];
    [[[self detailItemView] tableView] reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextViewCell *textViewCell = [tableView dequeueReusableCellWithIdentifier:@"TextViewCell"];
    
    [[textViewCell textView] setText:[[self rssItems] itemDescription]];
    [[textViewCell textView] setFont:[UIFont fontWithName:@"Helvetica Neue" size:contentFontSize]];

    return textViewCell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITextView *textView = [[UITextView alloc] init];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:[[self rssItems] itemDescription]];
    [textView setAttributedText:string];
    [textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:contentFontSize]];

    CGSize size = [textView sizeThatFits:CGSizeMake(300.0f, FLT_MAX)];

    return size.height - 20;

}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[self detailItemView] actionSheetShare] == actionSheet) {
        switch (buttonIndex) {
            case 0: [self shareEMail]; break;
            case 1: [self shareMessage]; break;
            case 2: [self shareFacebook]; break;
            case 3: [self shareTwitter]; break;
            case 4: [self openWebView]; break;
            default: break;
        }
    }
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error; {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Share Method
- (void)shareFacebook {
    @try {
        slComposeViewController = [[SLComposeViewController alloc] init];
        slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        [slComposeViewController setInitialText:[[self rssItems] itemDescription]];
        [slComposeViewController addURL:[[self rssItems] link]];

        [self presentViewController:slComposeViewController animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Ошибка при ширинге Facebook: %@", exception);
    }
}

- (void)shareTwitter {
    @try {
        slComposeViewController = [[SLComposeViewController alloc] init];
        slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        [slComposeViewController setInitialText:[[self rssItems] itemDescription]];
        [slComposeViewController addURL:[[self rssItems] link]];

        [self presentViewController:slComposeViewController animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Ошибка при ширинге в Twitter: %@", exception);
    }
}

- (void)shareEMail {
    @try {
        mfMailComposeViewController = [[MFMailComposeViewController alloc] init];
        [mfMailComposeViewController setSubject:[[self rssItems] title]];
        [mfMailComposeViewController setMessageBody:[[self rssItems] itemDescription] isHTML:YES];
        [mfMailComposeViewController setMailComposeDelegate:self];

        [self presentViewController:mfMailComposeViewController animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Ошибка при открытии E-Mail контроллера: %@", exception);
    }
}

- (void)shareMessage {
    @try {
        mfMessageComposeViewController = [[MFMessageComposeViewController alloc] init];
        [mfMessageComposeViewController setBody:[[self rssItems] itemDescription]];
        [mfMessageComposeViewController setMessageComposeDelegate:self];

        [self presentViewController:mfMessageComposeViewController animated:YES completion:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"Ошибка при открытии SMS контроллера: %@", exception);
    }
}

- (void)openWebView {
    modalWebViewController = [[SVModalWebViewController alloc] initWithURL:[[self rssItems] link]];
    [self presentViewController:modalWebViewController animated:YES completion:nil];
}

@end