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
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    fontSize = [userDefaults integerForKey:@"FONT_SIZE"];
    [[self textViewContent] setFont:[UIFont fontWithName:@"HelveticaNeue" size:fontSize]];
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    barButtonAaction = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                            target:self
                                                                            action:@selector(buttonBarAction:)];
    
    barButtonShare = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                          target:self
                                                                          action:@selector(buttonBarShareSocial:)];
    /*
    stringTitle = [[NSString alloc] init];
    stringPubDate = [[NSString alloc] init];
    stringItemDescription = [[NSString alloc] init];
    urlLink = [[NSURL alloc] init];
     */
    
    if ([Internet internetConnection] == NO) {
        [barButtonAaction setEnabled:NO];
        [barButtonShare setEnabled:NO];
    }
    else {
        self.navigationItem.rightBarButtonItems = @[barButtonAaction, barButtonShare];
        slComposeViewController = [[SLComposeViewController alloc] init];
        mfMailComposeViewController = [[MFMailComposeViewController alloc] init];
    }
    
    if (![_stringOfflineKey isEqualToString:@"Offline"]) {
        [self obtainingOnlineData];
    }
    else {
        [[self buttonAddNewsToOfflineOutlet] setEnabled:NO];
        [self obtainingOfflineData];
    }
    [self reloadData];
}

#pragma mark - Action
- (IBAction)buttonBarAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:NSLocalizedString(@"CANCEL", nil)
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:NSLocalizedString(@"OPEN", nil), NSLocalizedString(@"OPEN_IN_SAFARI", nil), NSLocalizedString(@"COPY_LINK", nil), nil];
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
        case 2: {
            UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
            [pasteboard setURL:urlLink];
            break;
        }
        default: {
            break;
        }
    }
}

- (IBAction)buttonAddNewsToOffline:(id)sender {
    [self addNewNews];
    
    UIAlertView *autoAlertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:NSLocalizedString(@"ADD_NEWS_TO_OFFLINE", nil)
                                                           delegate:self
                                                  cancelButtonTitle:nil
                                                  otherButtonTitles:nil];
    autoAlertView.transform = CGAffineTransformMake(1.0f, 0.5f, 0.0f, 1.0f, 0.0f, 0.0f);
    [autoAlertView performSelector:@selector(dismissWithClickedButtonIndex:animated:)
                        withObject:nil
                        afterDelay:1.5f];
    [autoAlertView show];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Button Share
- (IBAction)buttonBarShareSocial:(id)sender {
    UIAlertView *alertViewShare = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"SHARE", nil)
                                                             message:nil
                                                            delegate:self
                                                   cancelButtonTitle:NSLocalizedString(@"CANCEL", nil)
                                                   otherButtonTitles:NSLocalizedString(@"SEND_EMAIL", nil), NSLocalizedString(@"FACEBOOK", nil), NSLocalizedString(@"TWITTER", nil), nil];
    [alertViewShare show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 1: {
            [self sendEmail];
            break;
        }
        case 2: {
            [self shareFacebook];
            break;
        }
        case 3: {
            [self shareTwitter];
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark - Button Size
- (IBAction)buttonFondSizeAdd:(id)sender {
    fontSize ++;
    [self updateTextField];
}

- (IBAction)buttonFondSizeTake:(id)sender {
    fontSize --;
    [self updateTextField];
}

#pragma mark - SQL Query
- (void)addNewNews {
    [Client addNewNewsSetTitle:[_detailItem title] setDescription:[_detailItem itemDescription] setContent:[_detailItem content] setLink:[_detailItem link] setCommentsLink:[_detailItem commentsLink] setCommentsFeed:[_detailItem commentsFeed] setCommentsCount:[_detailItem commentsCount] setPubDate:[_detailItem pubDates] setAuthor:[_detailItem author] setGuid:[_detailItem guid] setCategory:[_detailItem category]];
}

- (BOOL)requestToLink:(NSString *)link {
    NSString *query = [[NSString alloc] initWithFormat:@"SELECT link FROM offline WHERE link = '%@'", link];
    NSString *result = [SQLiteAccess selectOneValueSQL:query];
    if (result == NULL) {
        return NO;
    }
    else {
        return YES;
    }
}

#pragma mark - Share Method
- (void)shareFacebook {
    slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [slComposeViewController setInitialText:stringItemDescription];
    [slComposeViewController addURL:urlLink];
    [self presentViewController:slComposeViewController animated:YES completion:nil];
}

- (void)shareTwitter {
    slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [slComposeViewController setInitialText:stringTitle];
    [slComposeViewController addURL:urlLink];
    [self presentViewController:slComposeViewController animated:YES completion:nil];
}

- (void)sendEmail {
    mfMailComposeViewController.mailComposeDelegate = self;
    [mfMailComposeViewController setSubject:stringTitle];
    [mfMailComposeViewController setMessageBody:stringItemDescription isHTML:YES];
    [self presentViewController:mfMailComposeViewController animated:YES completion:nil];
}

#pragma mark - MFMailComposeViewControllerDelegate
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error; {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Online
/*
- (void)setDetailItem:(RSSItem *)detailItem {
    _detailItem = detailItem;
}
 */
 
- (void)obtainingOnlineData {
    stringTitle = [_detailItem title];
    stringItemDescription = [_detailItem itemDescription];
    stringPubDate = [_detailItem pubDates];
    urlLink = [_detailItem link];
    
    if ([self requestToLink: (NSString *) urlLink] == YES) {
        [[self buttonAddNewsToOfflineOutlet] setEnabled:NO];
    }
}

#pragma mark - Offline
/*
- (void)setDetailItemOffline:(NSDictionary *)detailItemOffline {
    _detailItemOffline = detailItemOffline;
}
 */

- (void)obtainingOfflineData {
    stringTitle = [_detailItemOffline objectForKey:@"title"];
    stringItemDescription = [_detailItemOffline objectForKey:@"item_description"];
    stringPubDate = [_detailItemOffline objectForKey:@"pub_date"];
    urlLink = [NSURL URLWithString:[_detailItemOffline objectForKey:@"link"]];
}

#pragma mark - Reload
- (void)reloadData {
    [[self labelTitle] setText:stringTitle];
    [[self labelDate] setText:stringPubDate];
    [[self textViewContent] setText:stringItemDescription];
}

#pragma mark - Update Size
- (void)updateTextField {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:fontSize forKey:@"FONT_SIZE"];
    [userDefaults synchronize];

    [[self textViewContent] setFont:[UIFont fontWithName:@"HelveticaNeue" size:fontSize]];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"OpenLink"]) {
        WebViewController *webViewController = [segue destinationViewController];
        [webViewController setLink:urlLink];
    }
    else if ([[segue identifier] isEqualToString:@"OpenOneText"]) {
        OneTextView *oneTextView = [segue destinationViewController];
        [oneTextView setStringText:stringItemDescription];
    }
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
