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

#pragma mark - Action
- (IBAction)buttonSaveChanel:(id)sender {
    [self saveRssChanel];
}

- (void)reloadData {
    
    self.textFieldLink.text = [_dictionaryItems objectForKey:@"link"];
    self.textFieldTitle.text = [_dictionaryItems objectForKey:@"title"];
    self.textViewDescription.text = [_dictionaryItems objectForKey:@"description"];
    
}

- (void)setDictionaryItems:(NSDictionary *)dictionaryItems {
    _dictionaryItems = dictionaryItems;

}

#pragma mark - SQL Query
- (void)saveRssChanel {
    NSString *rssChanelID = [self.dictionaryItems objectForKey:@"id_rss_chanel"];
    
    NSString *queryString = [[NSString alloc] initWithFormat:@"UPDATE add_rss SET title = '%@', link = '%@', description = '%@' WHERE id_rss_chanel = '%@'",
                             [[self textFieldTitle] text],
                             [[self textFieldLink] text],
                             [[self textViewDescription] text],
                             rssChanelID];
    [SQLiteAccess updateWithSQL:queryString];
}


























@end
