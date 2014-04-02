#import <UIKit/UIKit.h>

@interface TextFieldCell : UITableViewCell

#pragma mark - UIImageView
@property (weak, nonatomic) IBOutlet UIImageView *ImageViewIcon;

#pragma mark - UITextField
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
