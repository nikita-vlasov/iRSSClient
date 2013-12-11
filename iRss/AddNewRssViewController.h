#import <UIKit/UIKit.h>
#import "SQLiteAccess.h"
#import "SelectionTableViewController.h"

@interface AddNewRssViewController : UIViewController {
    
}

#pragma mark - Action
- (IBAction)buttonSaveChanel:(id)sender;

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLink;
@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;

#pragma mark -
@property (strong, nonatomic) NSDictionary *dictionaryRssChanel;

@end
