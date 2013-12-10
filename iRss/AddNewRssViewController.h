#import <UIKit/UIKit.h>
#import "SQLiteAccess.h"

@interface AddNewRssViewController : UIViewController {
    
}

#pragma mark - Action
- (IBAction)buttonSaveChanel:(id)sender;

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UITextField *textFieldLink;
@property (weak, nonatomic) IBOutlet UITextView *textViewDescription;

#pragma mark -
- (NSArray *)arrayGetRssChanel;

@end
