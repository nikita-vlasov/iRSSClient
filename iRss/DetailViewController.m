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
    slComposeViewController = [[SLComposeViewController alloc] init];
    mfMailComposeViewController = [[MFMailComposeViewController alloc] init];
    
    if ([_stringOfflineKey isEqualToString:@"Offline"]) {
        [self reloadDataOffline];
    }
    else {
        [self reloadDataOnline];
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
            [[UIApplication sharedApplication] openURL:[_detailItem link]];
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
    [slComposeViewController setInitialText:[_detailItem itemDescription]];
    [slComposeViewController addURL:[_detailItem link]];
    [self presentViewController:slComposeViewController animated:YES completion:nil];
}

- (IBAction)buttonShareTwitter:(id)sender {
    slComposeViewController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [slComposeViewController setInitialText:[_detailItem title]];
    [slComposeViewController addURL:[_detailItem link]];
    [self presentViewController:slComposeViewController animated:YES completion:nil];
}

- (IBAction)buttonSendEmail:(id)sender {
    mfMailComposeViewController.mailComposeDelegate = self;
    [mfMailComposeViewController setSubject:[_detailItem title]];
    [mfMailComposeViewController setMessageBody:[_detailItem itemDescription] isHTML:YES];
    [self presentViewController:mfMailComposeViewController animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error; {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Online
- (void)setDetailItem:(RSSItem *)detailItem {
    _detailItem = detailItem;
}

- (void)reloadDataOnline {
    self.labelTitle.text = [_detailItem title];
    self.labelDate.text = [_detailItem pubDates];
    self.textViewContent.text = [_detailItem itemDescription];
}

#pragma mark - Offline
- (void)setDetailItemOffline:(NSDictionary *)detailItemOffline {
    _detailItemOffline = detailItemOffline;
}

- (void)reloadDataOffline {
    self.labelTitle.text = [_detailItemOffline objectForKey:@"title"];
    self.labelDate.text = [_detailItemOffline objectForKey:@"pub_date"];
    self.textViewContent.text = [_detailItemOffline objectForKey:@"item_description"];
    
    _buttonBarActionOutlet.enabled = NO;
    _buttonAddNewsToOfflineOutlet.enabled = NO;
    _buttonShareFacebookOutlet.enabled = NO;
    _buttonShareTwitterOutlet.enabled = NO;
    _buttonSendEmailOutlet.enabled = NO;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewController *webViewController = segue.destinationViewController;
    webViewController.link = [_detailItem link];
}

@end
