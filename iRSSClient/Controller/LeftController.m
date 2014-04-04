#import "LeftController.h"
#import "LeftView.h"
#import "UIViewController+MMDrawerController.h"
#import "DrawerFactory.h"
#import "IconViewCell.h"
#import "LeftModel.h"

@interface LeftController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate> {
    @private
    LeftModel *leftModel;
    NSArray *arrayTitle;

    NSArray *arrayFiltered;

    BOOL isSearch;
}

/** View */
@property (strong, nonatomic) IBOutlet LeftView *leftView;

@end


@implementation LeftController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationItem] setTitle:NSLocalizedString(@"Menu", nil)];
    [[_leftView searchBar] setPlaceholder:NSLocalizedString(@"Search", nil)];
    [[_leftView tableView] setContentOffset:CGPointMake(0, 44)];

    arrayTitle = [LeftModel createLeftMenu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [[_leftView searchBar] resignFirstResponder];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title contains[cd] %@", searchText];
    arrayFiltered = [arrayTitle filteredArrayUsingPredicate:predicate];

    if (![searchText length] == 0) isSearch = YES;
    else isSearch = NO;

    [[_leftView tableView] reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearch == YES) return [arrayFiltered count];
    return [arrayTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IconViewCell *iconViewCell = [tableView dequeueReusableCellWithIdentifier:@"IconViewCell"];

    if (isSearch == YES) leftModel = [arrayFiltered objectAtIndex:[indexPath row]];
    else leftModel = [arrayTitle objectAtIndex:[indexPath row]];

    [[iconViewCell labelTitle] setText:[leftModel valueForKey:@"title"]];
    [[iconViewCell ImageViewIcon] setImage:[UIImage imageNamed:[leftModel valueForKey:@"icon"]]];

    return iconViewCell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self openControllers:[indexPath row]];
}

/** Метод, дает возможность открыть необходимы контролер по индексу ячейки. */
- (void)openControllers:(int)index {
    if (isSearch == YES) leftModel = [arrayFiltered objectAtIndex:index];
    else leftModel = [arrayTitle objectAtIndex:index];

    if ([[leftModel valueForKey:@"key"] isEqualToString:@"Dashboard"]) {
        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] dashboardController] withCloseAnimation:YES completion:nil];
    }
    else if ([[leftModel valueForKey:@"key"] isEqualToString:@"Channel"]) {
        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] channelController] withCloseAnimation:YES completion:nil];
    }
    else if ([[leftModel valueForKey:@"key"] isEqualToString:@"Setting"]) {
        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] settingController] withCloseAnimation:YES completion:nil];
    }
}

@end
