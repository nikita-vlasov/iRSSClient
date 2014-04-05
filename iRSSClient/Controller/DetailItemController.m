#import "DetailItemController.h"
#import "DetailItemView.h"
#import "TextViewCell.h"

@interface DetailItemController () <UITableViewDataSource, UITableViewDelegate>

/** View. */
@property (strong, nonatomic) IBOutlet DetailItemView *detailItemView;

@end


@implementation DetailItemController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
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
//    [[[self detailItemView] labelDate] setText:[[self rssItems] pubDate]];
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

//UITextView *textView = [[UITextView alloc] init];
//[textView setAttributedText:text];
//CGSize size = [textView sizeThatFits:CGSizeMake(width, FLT_MAX)];
//return size.height;

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITextView *textView = [[UITextView alloc] init];
    NSAttributedString *string = [[NSAttributedString alloc] initWithString:[[self rssItems] itemDescription]];
    [textView setAttributedText:string];
    [textView setFont:[UIFont fontWithName:@"Helvetica Neue" size:14.0f]];

    CGSize size = [textView sizeThatFits:CGSizeMake(300.0f, FLT_MAX)];

    return size.height;

}

@end