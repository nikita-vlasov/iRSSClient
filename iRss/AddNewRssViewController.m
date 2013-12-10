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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action
- (IBAction)buttonSaveChanel:(id)sender {
    [self saveRssChanel];
}

#pragma mark - SQL Query
- (void)saveRssChanel {
    NSString *queryString = [[NSString alloc] initWithFormat:@"INSERT INTO add_rss (link, description) VALUES ('%@', '%@')",
                       [[self textFieldLink] text],
                       [[self textViewDescription] text]];
    [SQLiteAccess updateWithSQL:queryString];
}


@end
