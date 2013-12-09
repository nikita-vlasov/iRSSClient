#import "DetailViewController.h"

@interface DetailViewController () {
    
}

@end


@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   fontName = [[UIFontDescriptor alloc] fontDescriptorWithFace:@"HelveticaNeue"];
    
    stringTitle = [[NSString alloc] init];
    stringPubDate = [[NSString alloc] init];
    stringItemDescription = [[NSString alloc] init];
    urlLink = [[NSURL alloc] init];
    
    if ([Internet internetConnection] == NO) {
        [self switchOffButtons];
    }
    else {
        slComposeViewController = [[SLComposeViewController alloc] init];
        mfMailComposeViewController = [[MFMailComposeViewController alloc] init];
    }
    
    if (![_stringOfflineKey isEqualToString:@"Offline"]) {
        [self obtainingOnlineData];
        [self reloadData];
    }
    else {
        _buttonAddNewsToOfflineOutlet.enabled = NO;
        [self obtainingOfflineData];
        [self reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action
- (IBAction)buttonBarAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"CANCEL", nil)
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"OPEN", nil), NSLocalizedString(@"OPEN_IN_SAFARI", nil), nil];
    [actionSheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            [self performSegueWithIdentifier:@"OpenLink" sender:self];
            break;
        }
        case 1: {
            [[UIApplication sharedApplication] openURL:urlLink];
            break;
        }
        default: {
            break;
        }
    }
}

- (IBAction)buttonAddNewsToOffline:(id)sender {
    NSString *queryString = [NSString stringWithFormat:@"INSERT INTO offline (title, item_description, content, link, comments_link, comments_feed, comments_count, pub_date, author, guid, category) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",
                             [_detailItem title],
                             [_detailItem itemDescription],
                             [_detailItem content],
                             [_detailItem link],
                             [_detailItem commentsLink],
                             [_detailItem commentsFeed],
                             [_detailItem commentsCount],
                             [_detailItem pubDates],
                             [_detailItem author],
                             [_detailItem guid],
                             [_detailItem category]];
    
    [SQLiteAccess updateWithSQL:queryString];
    [self.navigationController popViewControllerAnimated:YES];
    
    UIAlertView *autoAlertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:NSLocalizedString(@"ADD_NEWS_TO_OFFLINE", "")
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:nil];
    autoAlertView.transform = CGAffineTransformMake(1.0f, 0.5f, 0.0f, 1.0f, 0.0f, 0.0f);
    [autoAlertView performSelector:@selector(dismissWithClickedButtonIndex:animated:)
                        withObject:nil
                        afterDelay:1.5f];
    [autoAlertView show];
}

- (IBAction)buttonShareFacebook:(id)sender {
    slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [slComposeViewController setInitialText:stringItemDescription];
    [slComposeViewController addURL:urlLink];
    [self presentViewController:slComposeViewController animated:YES completion:nil];
}

- (IBAction)buttonShareTwitter:(id)sender {
    slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [slComposeViewController setInitialText:stringTitle];
    [slComposeViewController addURL:urlLink];
    [self presentViewController:slComposeViewController animated:YES completion:nil];
}

- (IBAction)buttonSendEmail:(id)sender {
    mfMailComposeViewController.mailComposeDelegate = self;
    [mfMailComposeViewController setSubject:stringTitle];
    [mfMailComposeViewController setMessageBody:stringItemDescription isHTML:YES];
    [self presentViewController:mfMailComposeViewController animated:YES completion:nil];
}

#pragma mark - MFMail Compose View Controller Delegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error; {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Online
- (void)setDetailItem:(RSSItem *)detailItem {
    _detailItem = detailItem;
}

- (void)obtainingOnlineData {
    stringTitle = [_detailItem title];
    stringItemDescription = [_detailItem itemDescription];
    stringPubDate = [_detailItem pubDates];
    urlLink = [_detailItem link];
}

#pragma mark - Offline
- (void)setDetailItemOffline:(NSDictionary *)detailItemOffline {
    _detailItemOffline = detailItemOffline;
}

- (void)obtainingOfflineData {
    stringTitle = [_detailItemOffline objectForKey:@"title"];
    stringItemDescription = [_detailItemOffline objectForKey:@"item_description"];
    stringPubDate = [_detailItemOffline objectForKey:@"pub_date"];
    urlLink = [NSURL URLWithString:[_detailItemOffline objectForKey:@"link"]];
}

#pragma mark -
- (void)reloadData {
    self.labelTitle.text = stringTitle;
    self.labelDate.text = stringPubDate;
    self.textViewContent.text = stringItemDescription;
}

#pragma mark - Font
- (void)fontSizeAdd {
    fontSize ++;
    self.textViewContent.font = [UIFont fontWithDescriptor:fontName size:fontSize];
}

- (void)fondSizeTake {
    fontSize --;
    self.textViewContent.font = [UIFont fontWithDescriptor:fontName size:fontSize];
}

#pragma mark - Hiding Buttons
- (void)switchOffButtons {
    _buttonBarActionOutlet.enabled = NO;
    _buttonShareFacebookOutlet.enabled = NO;
    _buttonShareTwitterOutlet.enabled = NO;
    _buttonSendEmailOutlet.enabled = NO;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewController *webViewController = segue.destinationViewController;
    webViewController.link = urlLink;
}

@end
