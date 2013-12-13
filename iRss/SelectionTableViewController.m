#import "SelectionTableViewController.h"
#import "AddNewRssViewController.h"

@interface SelectionTableViewController () {
    UIBarButtonItem *buttonAdd;
}

@end


@implementation SelectionTableViewController

- (id)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[self tableView] reloadData];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
    self.navigationItem.title = NSLocalizedString(@"ALL_RSS", nil);
    
    buttonAdd = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                            target:self
                                                                            action:@selector(buttonAddNewRssChanel:)];
    
    UIBarButtonItem *buttonTrash =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemTrash
                                                                          target:self
                                                                          action:@selector(buttonBarTrashAllChanel:)];
    
    self.navigationItem.rightBarButtonItems = @[buttonAdd, buttonTrash];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

#pragma mark - Action
- (IBAction)buttonAddNewRssChanel:(id)sender {
    [SQLiteAccess updateWithSQL:@"INSERT INTO add_rss (title, link, description) VALUES ('Hot News', 'http://images.apple.com/main/rss/hotnews/hotnews.rss', 'Apple Hot News')"];
    [[self tableView] reloadData];
}

- (IBAction)buttonBarTrashAllChanel:(id)sender {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Warning" message:@"Do you really want to delete all RSS feeds? Be careful, these data can not be recovered." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Delete", nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
        case 0:{
            break;
        }
        case 1: {
            [ResetSettingToDefault cleanerAllRssChanel];
            [[self tableView] reloadData];
            break;
        }
        default: {
            break;
        }
    }
}

#pragma mark SQL
- (NSArray *)arrayGetRssChanel {
    return [SQLiteAccess selectManyRowsWithSQL:@"SELECT * FROM add_rss"];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self arrayGetRssChanel] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    NSDictionary *dictionary = [[self arrayGetRssChanel] objectAtIndex:indexPath.section];
    cell.textLabel.text = [dictionary objectForKey:@"title"];
   
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSDictionary *dictionary = [[self arrayGetRssChanel] objectAtIndex:indexPath.section];
        NSString *addRssID = [dictionary objectForKey:@"id_rss_chanel"];
        NSString *queryString = [[NSString alloc] initWithFormat:@"DELETE FROM add_rss WHERE id_rss_chanel = '%@'", addRssID];

        [SQLiteAccess deleteWithSQL:queryString];
        [tableView deleteSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationFade];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSDictionary *dictionary = [[self arrayGetRssChanel] objectAtIndex:section];
    return [dictionary objectForKey:@"description"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath {
    if (UITableViewCellAccessoryDisclosureIndicator) {
        dictionaryRssChanel = [[self arrayGetRssChanel] objectAtIndex:indexPath.section];
        [self performSegueWithIdentifier:@"OpenAddRssChanel" sender:self];
    }
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSIndexPath *indexPath = [[self tableView] indexPathForSelectedRow];
    if (indexPath) {
        TableViewController *tableViewController = [segue destinationViewController];
        NSDictionary *dictionary = [[self arrayGetRssChanel] objectAtIndex:indexPath.section];
        NSString *stringUrlLink = [dictionary objectForKey:@"link"];
        [tableViewController setLinkToTheRssFeeds:stringUrlLink];
    }
    if ([[segue identifier] isEqualToString:@"OpenAddRssChanel"]) {
        AddNewRssViewController *addNewRssViewController = [segue destinationViewController];
        [addNewRssViewController setDictionaryRssChanel:dictionaryRssChanel];
    }
}

@end
