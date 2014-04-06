#import <UIKit/UIKit.h>

@interface FontSizeView : UIView

#pragma mark - UIStepper
@property (weak, nonatomic) IBOutlet UIStepper *stepperButton;

#pragma mark - UILabel
@property (weak, nonatomic) IBOutlet UILabel *labelFontSize;

#pragma mark - UINavigationBar
@property (weak, nonatomic) IBOutlet UINavigationBar *navigationBar;

@end
