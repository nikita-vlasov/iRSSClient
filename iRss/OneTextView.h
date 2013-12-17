#import <UIKit/UIKit.h>

@interface OneTextView : UIViewController {
    
}

#pragma mark - Action
- (IBAction)buttonToolbarDone:(id)sender;

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UITextView *textViewOneText;

#pragma mark -
@property (strong, nonatomic) NSString *stringText;

@end
