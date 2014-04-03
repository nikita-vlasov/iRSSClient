#import "EditChannelController.h"
#import "EditChannelView.h"
#import "TextFieldCell.h"
#import "Channel.h"

@interface EditChannelController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate> {
    @private
    NSManagedObjectContext *managedObjectContext;
    Channel *channel;
}

/** View */
@property (strong, nonatomic) IBOutlet EditChannelView *editChannelView;

@end


@implementation EditChannelController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [[self navigationItem] setTitle:NSLocalizedString(@"Edit", nil)];

    managedObjectContext = [(AppDelegate *) [[UIApplication sharedApplication] delegate] managedObjectContext];
    channel = [[Channel alloc] init];

    [[_editChannelView barButtonSave] setTitle:NSLocalizedString(@"Save", nil)];
    [[_editChannelView barButtonSave] setAction:@selector(saveChannel:)];
    [[_editChannelView barButtonSave] setTarget:self];

    [[_editChannelView alertViewAction] setTitle:NSLocalizedString(@"Warning", nil)];
    [[_editChannelView alertViewAction] setMessage:@""];
    [[_editChannelView alertViewAction] addButtonWithTitle:@"OK"];
    [[_editChannelView alertViewAction] addButtonWithTitle:NSLocalizedString(@"Cancel", nil)];
    [[_editChannelView alertViewAction] setDelegate:self];

    [[self navigationItem] setRightBarButtonItem:[[self editChannelView] barButtonSave]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)saveChannel:(UIBarButtonItem *)sender {
    [[_editChannelView tableView] reloadData];
    [[_editChannelView alertViewAction] show];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TextFieldCell *textFieldCell = [tableView dequeueReusableCellWithIdentifier:@"TextFieldCell"];

    if ([indexPath row] == 0) {
        [[textFieldCell textField] setPlaceholder:NSLocalizedString(@"Title", nil)];
        [channel setValue:[[textFieldCell textField] text] forKey:@"title"];
        return textFieldCell;
    }
    else if ([indexPath row] == 1) {
        [[textFieldCell textField] setPlaceholder:NSLocalizedString(@"Link", nil)];
        [channel setValue:[[textFieldCell textField] text] forKey:@"link"];
        return textFieldCell;
    }
    else if ([indexPath row] == 2) {
        [[textFieldCell textField] setPlaceholder:NSLocalizedString(@"Description", nil)];
        [channel setValue:[[textFieldCell textField] text] forKey:@"designation"];
        return textFieldCell;
    }

    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"--- %@", [textField text]);

    return YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([_editChannelView alertViewAction] == alertView) {
        switch (buttonIndex) {
            case 0: [self saveChannel]; break;
            default: break;
        }
    }
}

- (void)saveChannel {
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Channel" inManagedObjectContext:managedObjectContext];
    [managedObject setValue:[channel title] forKey:@"title"];
    [managedObject setValue:[channel link] forKey:@"link"];
    [managedObject setValue:[channel description] forKey:@"designation"];

    NSError *error = nil;
    [managedObjectContext save:&error];
}

@end
