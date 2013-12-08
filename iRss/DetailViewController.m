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
    [self reloadDataOnline];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action
- (IBAction)buttonBarAction:(id)sender {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Open", @"Open in Safari", nil];
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
    
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    WebViewController *webViewController = segue.destinationViewController;
    webViewController.link = [_detailItem link];
}

@end
