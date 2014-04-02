#import "EditChannelController.h"
#import "EditChannelView.h"
#import "TextFieldCell.h"

@interface EditChannelController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

/** View */
@property (strong, nonatomic) IBOutlet EditChannelView *editChannelView;

@end


@implementation EditChannelController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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
        return textFieldCell;
    }
    else if ([indexPath row] == 1) {
        [[textFieldCell textField] setPlaceholder:NSLocalizedString(@"Link", nil)];
        return textFieldCell;
    }
    else if ([indexPath row] == 2) {
        [[textFieldCell textField] setPlaceholder:NSLocalizedString(@"Description", nil)];
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

@end
