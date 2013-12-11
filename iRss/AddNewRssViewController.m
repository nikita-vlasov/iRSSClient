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
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SQL Query
- (void)saveRssChanel {
    NSString *rssChanelID = [self.dictionaryRssChanel objectForKey:@"id_rss_chanel"];
    NSString *queryString = [[NSString alloc] initWithFormat:@"UPDATE add_rss SET title = '%@', link = '%@', description = '%@' WHERE id_rss_chanel = '%@'",
                             [[self textFieldTitle] text],
                             [[self textFieldLink] text],
                             [[self textViewDescription] text],
                             rssChanelID];
    [SQLiteAccess updateWithSQL:queryString];
}

- (void)reloadData {
    self.textFieldLink.text = [self.dictionaryRssChanel objectForKey:@"link"];
    self.textFieldTitle.text = [self.dictionaryRssChanel objectForKey:@"title"];
    self.textViewDescription.text = [self.dictionaryRssChanel objectForKey:@"description"];
}

@end
