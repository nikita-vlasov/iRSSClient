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
}

- (IBAction)buttonAddNewsToOffline:(id)sender {
}

- (IBAction)buttonShareFacebook:(id)sender {
}

- (IBAction)buttonShareTwitter:(id)sender {
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
//    WebViewController *webViewController = segue.destinationViewController;
//    webViewController.link = [_detail link];
}

@end
