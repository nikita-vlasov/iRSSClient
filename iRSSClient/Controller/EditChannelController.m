#import "EditChannelController.h"
#import "EditChannelView.h"
#import "TextFieldCell.h"
#import "Channel.h"

@interface EditChannelController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate, UITextFieldDelegate> {
    @private
    NSManagedObjectContext *managedObjectContext;
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

    [[_editChannelView barButtonSave] setTitle:NSLocalizedString(@"Save", nil)];
    [[_editChannelView barButtonSave] setAction:@selector(saveChannel:)];
    [[_editChannelView barButtonSave] setTarget:self];

    [[self navigationItem] setRightBarButtonItem:[[self editChannelView] barButtonSave]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    _channel = nil;
}

- (void)saveChannel:(UIBarButtonItem *)sender {
    [self becomeFirstResponder];
    [self setEditing:YES];

    if (![self channel]) {
        [self saveChannel];
    }
    else [managedObjectContext save:nil];
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
        [[textFieldCell textField] setText:[[self channel] valueForKey:@"title"]];
        [[textFieldCell textField] setTag:0];

        return textFieldCell;
    }
    else if ([indexPath row] == 1) {
        [[textFieldCell textField] setPlaceholder:NSLocalizedString(@"Link", nil)];
        [[textFieldCell textField] setText:[[self channel] valueForKey:@"link"]];
        [[textFieldCell textField] setTag:1];

        return textFieldCell;
    }
    else if ([indexPath row] == 2) {
        [[textFieldCell textField] setPlaceholder:NSLocalizedString(@"Description", nil)];
        [[textFieldCell textField] setText:[[self channel] valueForKey:@"designation"]];
        [[textFieldCell textField] setTag:2];

        return textFieldCell;
    }

    return nil;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    switch ([textField tag]) {
        case 0: [[self channel] setValue:[textField text] forKey:@"title"]; break;
        case 1: [[self channel] setValue:[textField text] forKey:@"link"]; break;
        case 2: [[self channel] setValue:[textField text] forKey:@"designation"]; break;
        default: break;
    }

    [managedObjectContext save:nil];
}

- (void)saveChannel {
    NSManagedObject *managedObject = [NSEntityDescription insertNewObjectForEntityForName:@"Channel"
                                                                   inManagedObjectContext:managedObjectContext];
    [managedObject setValue:[[self channel] title] forKey:@"title"];
    [managedObject setValue:[[self channel] link] forKey:@"link"];
    [managedObject setValue:[[self channel] description] forKey:@"designation"];

    NSError *error = nil;
    [managedObjectContext save:&error];
}

@end
