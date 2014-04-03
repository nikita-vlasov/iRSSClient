#import "LeftController.h"
#import "LeftView.h"
#import "UIViewController+MMDrawerController.h"
#import "DrawerFactory.h"
#import "IconViewCell.h"
#import "LeftModel.h"

@interface LeftController () <UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UIScrollViewDelegate> {
    @private
//    NSMutableArray *arrayTitle;
    LeftModel *leftModel;
    NSArray *arrayTitle;
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

//    arrayTitle = [[NSMutableArray alloc] init];

//    [arrayTitle addObject:@{@"title" : NSLocalizedString(@"Dashboard", nil), @"icon" : @"icon_home.png"}];
//    [arrayTitle addObject:@{@"title" : NSLocalizedString(@"Channel", nil), @"icon" : @"icon_channel.png"}];
//    [arrayTitle addObject:@{@"title" : NSLocalizedString(@"Setting", nil), @"icon" : @"icon_settings.png"}];

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
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrayTitle count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IconViewCell *iconViewCell = [tableView dequeueReusableCellWithIdentifier:@"IconViewCell"];

    leftModel = [arrayTitle objectAtIndex:[indexPath row]];

//    [[iconViewCell labelTitle] setText:[[arrayTitle objectAtIndex:[indexPath row]] valueForKey:@"title"]];
//    [[iconViewCell ImageViewIcon] setImage:[UIImage imageNamed:[[arrayTitle objectAtIndex:[indexPath row]] valueForKey:@"icon"]]];

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
    leftModel = [arrayTitle objectAtIndex:index];
    if (index == 0) {
        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] dashboardController] withCloseAnimation:YES completion:nil];
    }
    else if (index == 1) {
        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] channelController] withCloseAnimation:YES completion:nil];
    }
    else if (index == 2) {
        [[self mm_drawerController] setCenterViewController:[[DrawerFactory sharedFactory] settingController] withCloseAnimation:YES completion:nil];
    }
}

@end
