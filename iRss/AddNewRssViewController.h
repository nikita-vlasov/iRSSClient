#import <UIKit/UIKit.h>
#import "SQLiteAccess.h"
#import "SelectionTableViewController.h"

@interface AddNewRssViewController : UIViewController {
    
}

#pragma mark - Action
- (IBAction)buttonSaveChanel:(id)sender;

#pragma mark - Button Outlet


#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UITextField *textFieldTitle;
@property (weak, nonatomic) IBOutlet UITextField *textFieldLink;
@property (weak, nonatomic) IBOutlet UITextField *textFieldDescription;

@property (weak, nonatomic) IBOutlet UIImageView *imageTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageLink;
#pragma mark -
@property (strong, nonatomic) NSDictionary *dictionaryRssChanel;

@end
