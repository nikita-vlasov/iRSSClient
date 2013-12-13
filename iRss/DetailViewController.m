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
    self.textViewContent.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
    
    barButtonAaction = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                                                            target:self
                                                                            action:@selector(buttonBarAction:)];
    
    barButtonShare =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemReply
                                                                          target:self
                                                                          action:@selector(buttonBarShareSocial:)];
    self.navigationItem.rightBarButtonItems = @[barButtonAaction, barButtonShare];
    
    stringTitle = [[NSString alloc] init];
    stringPubDate = [[NSString alloc] init];
    stringItemDescription = [[NSString alloc] init];
    urlLink = [[NSURL alloc] init];
    
    if (![Internet internetConnection] == NO) {
        slComposeViewController = [[SLComposeViewController alloc] init];
        mfMailComposeViewController = [[MFMailComposeViewController alloc] init];
        [barButtonAaction setEnabled:NO];
        [barButtonShare setEnabled:NO];
    }

    if (![_stringOfflineKey isEqualToString:@"Offline"]) {
        [self obtainingOnlineData];
    }
    else {
        _buttonAddNewsToOfflineOutlet.enabled = NO;
        [self obtainingOfflineData];
    }
    [self reloadData];
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
                                                    otherButtonTitles:NSLocalizedString(@"OPEN", nil), NSLocalizedString(@"OPEN_IN_SAFARI", nil), @"Copy link", nil];
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
    if ([self requestToLink: (NSString *) urlLink] == YES) {
        NSLog(@"Уже есть такая новость");
        return;
    }
    else {
        NSLog(@"Нет такой новости");
        [self addNewNews];
        
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
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - Button Share
- (IBAction)buttonBarShareSocial:(id)sender {
    UIAlertView *alertViewShare = [[UIAlertView alloc] initWithTitle:@"Share"
                                                             message:nil
                                                            delegate:self
                                                   cancelButtonTitle:@"Cancel"
                                                   otherButtonTitles:@"Email", @"Facebook", @"Twitter", nil];
    [alertViewShare show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0: {
            break;
        }
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
    NSDate *dateToday =[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEE, dd MMM yyyy HH:mm:ss"];
    NSString *stringTodayDate = [dateFormatter stringFromDate:dateToday];
    
    NSString *queryString = [NSString stringWithFormat:@"INSERT INTO offline (title, item_description, content, link, comments_link, comments_feed, comments_count, pub_date, author, guid, category, date_added) VALUES ('%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@', '%@')",
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
                             [_detailItem category],
                             stringTodayDate];
    
    [SQLiteAccess insertWithSQL:queryString];
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

#pragma mark - Reload
- (void)reloadData {
    self.labelTitle.text = stringTitle;
    self.labelDate.text = stringPubDate;
    self.textViewContent.text = stringItemDescription;
}

#pragma mark - Update Size
- (void)updateTextField {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:fontSize forKey:@"FONT_SIZE"];
    [userDefaults synchronize];

    self.textViewContent.font = [UIFont fontWithName:@"HelveticaNeue" size:fontSize];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewController *webViewController = segue.destinationViewController;
    [webViewController setLink:urlLink];
}

@end
