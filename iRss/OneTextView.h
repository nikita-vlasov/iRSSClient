#import <UIKit/UIKit.h>

@interface OneTextView : UIViewController {
    @private
    NSInteger fontSize;
}

#pragma mark - Action
- (IBAction)buttonToolbarDone:(id)sender;
- (IBAction)buttonToolbarFondSizeAdd:(id)sender;
- (IBAction)buttonToolbarFondSizeTake:(id)sender;

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UITextView *textViewOneText;

#pragma mark -
@property (strong, nonatomic) NSString *stringText;

@end
