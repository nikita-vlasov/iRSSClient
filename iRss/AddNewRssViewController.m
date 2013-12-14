#import "AddNewRssViewController.h"

@interface AddNewRssViewController () {
    
}

@end


@implementation AddNewRssViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self labelTitle] setText:NSLocalizedString(@"TITLE", nil)];
    [[self textFieldTitle] setPlaceholder:NSLocalizedString(@"TITLE", nil)];
    [[self labelLink] setText:NSLocalizedString(@"LINK", nil)];
    [[self textFieldLink] setPlaceholder:NSLocalizedString(@"LINK", nil)];
    [[self labelDescription] setText:NSLocalizedString(@"DESCRIPTION", nil)];
    [[self textFieldDescription] setPlaceholder:NSLocalizedString(@"DESCRIPTION", nil)];
    
    [self reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Setter
- (void)setDictionaryRssChanel:(NSDictionary *)dictionaryRssChanel {
    _dictionaryRssChanel = dictionaryRssChanel;
}

#pragma mark - Action
- (IBAction)buttonSaveChanel:(id)sender {
    [self saveRssChanel];
}

#pragma mark - SQL Query
- (void)saveRssChanel {
    if ([self.textFieldTitle.text isEqualToString:@""]) {
        self.imageTitle.backgroundColor = [UIColor redColor];
    }
    else {
        self.imageTitle.backgroundColor = [UIColor greenColor];
    }
    if ([self.textFieldLink.text isEqualToString:@""]) {
        self.imageLink.backgroundColor = [UIColor redColor];
    }
    else {
        self.imageLink.backgroundColor = [UIColor greenColor];
    }
    
    if ([self.imageTitle.backgroundColor isEqual:[UIColor greenColor]] && [self.imageLink.backgroundColor isEqual:[UIColor greenColor]]) {
        NSString *rssChanelID = [self.dictionaryRssChanel objectForKey:@"id_rss_chanel"];
        NSString *queryString = [[NSString alloc] initWithFormat:@"UPDATE add_rss SET title = '%@', link = '%@', description = '%@' WHERE id_rss_chanel = '%@'",
                                 [[self textFieldTitle] text],
                                 [[self textFieldLink] text],
                                 [[self textFieldDescription] text],
                                 rssChanelID];
        [SQLiteAccess updateWithSQL:queryString];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)reloadData {
    [[self textFieldTitle] setText:[[self dictionaryRssChanel] objectForKey:@"title"]];
    [[self textFieldLink] setText:[[self dictionaryRssChanel] objectForKey:@"link"]];
    [[self textFieldDescription] setText:[[self dictionaryRssChanel] objectForKey:@"description"]];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [[self textFieldTitle] resignFirstResponder];
    [[self textFieldLink] resignFirstResponder];
    [[self textFieldDescription] resignFirstResponder];
}

@end
