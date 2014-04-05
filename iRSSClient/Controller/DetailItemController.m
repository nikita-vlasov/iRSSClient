#import "DetailItemController.h"
#import "DetailItemView.h"
#import "TextViewCell.h"
#import "NSDate+Date.h"

@interface DetailItemController () <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate> {
    @private
    UIBarButtonItem *barButtonShare;
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
    [[self navigationItem] setRightBarButtonItems:@[barButtonShare]];

    [[[self detailItemView] actionSheetShare] addButtonWithTitle:NSLocalizedString(@"E-Mail", nil)];
    [[[self detailItemView] actionSheetShare] addButtonWithTitle:NSLocalizedString(@"Message", nil)];
    [[[self detailItemView] actionSheetShare] addButtonWithTitle:NSLocalizedString(@"Facebook", nil)];
    [[[self detailItemView] actionSheetShare] addButtonWithTitle:NSLocalizedString(@"Twitter", nil)];
    [[[self detailItemView] actionSheetShare] addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];

    [[[self detailItemView] actionSheetShare] setCancelButtonIndex:4];
    [[[self detailItemView] actionSheetShare] setDelegate:self];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)reloadData {
    [[[self detailItemView] labelTitle] setText:[[self rssItems] title]];
    [[[self detailItemView] labelAuthor] setText:[[self rssItems] author]];
    [[[self detailItemView] labelDate] setText:[NSDate getFormattetDateSetDate:[[self rssItems] pubDate]]];
}

#pragma mark - UIBarButtonItem
- (void)shareButton:(UIBarButtonItem *)sender {
    [[[self detailItemView] actionSheetShare] showInView:[self detailItemView]];
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

    return textViewCell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITextView *textView = [[UITextView alloc] init];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:[[self rssItems] itemDescription]];
    [textView setAttributedText:string];
    [textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];

    CGSize size = [textView sizeThatFits:CGSizeMake(300.0f, FLT_MAX)];

    return size.height;

}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([[self detailItemView] actionSheetShare] == actionSheet) {
        switch (buttonIndex) {
            case 0: [self shareEMail]; break;
            case 1: [self shareMessage]; break;
            case 2: [self shareFacebook]; break;
            case 3: [self shareTwitter]; break;
            default: break;
        }
    }
}

#pragma mark - Share
- (void)shareEMail {

}

- (void)shareMessage {

}

- (void)shareFacebook {

}

- (void)shareTwitter {

}

@end