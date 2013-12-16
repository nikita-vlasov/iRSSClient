#import "EditChannelTableViewController.h"

@interface EditChannelTableViewController () {
    
}

@end


@implementation EditChannelTableViewController
//@synthesize tableView;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    stringTitle = [[NSString alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Action
- (IBAction)buttonBarSave:(id)sender {
    NSLog(@"T = %@", stringTitle);
    NSLog(@"L = %@", stringLink);
    NSLog(@"D = %@", stringDescription);
}

- (IBAction)buttonBarCancel:(id)sender {
    [[self tableView] reloadData];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCellEditChannel *cell = [tableView dequeueReusableCellWithIdentifier:@"CellEditChannel"];
    
    if ([indexPath row] == 0) {
        [[cell labelCellEdit] setText:@"Title"];
        [[cell textFieldCellEdit] setPlaceholder:@"Title"];
        stringTitle = [[cell textFieldCellEdit] text];
        return cell;
    }
    if ([indexPath row] == 1) {
        [[cell labelCellEdit] setText:@"Link"];
        [[cell textFieldCellEdit] setPlaceholder:@"Link"];
        stringLink = [[cell textFieldCellEdit] text];
        return cell;
    }
    if ([indexPath row] == 2) {
        [[cell labelCellEdit] setText:@"Descripton"];
        [[cell textFieldCellEdit] setPlaceholder:@"Descripton"];
        stringDescription = [[cell textFieldCellEdit] text];
        return cell;
    }
    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.1f;
}

@end
