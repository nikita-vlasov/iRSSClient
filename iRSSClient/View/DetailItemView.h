#import <UIKit/UIKit.h>
#import "LeftView.h"

@interface DetailItemView : LeftView

#pragma mark - UILabel
@property (weak, nonatomic) IBOutlet UILabel *labelTitle;
@property (weak, nonatomic) IBOutlet UILabel *labelDate;
@property (weak, nonatomic) IBOutlet UILabel *labelAuthor;

@property (strong, nonatomic) UIActionSheet *actionSheetShare;

@end
