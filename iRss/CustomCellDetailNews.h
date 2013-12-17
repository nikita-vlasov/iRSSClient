#import <UIKit/UIKit.h>

@interface CustomCellDetailNews : UITableViewCell {
    
}

#pragma mark - Outlet
@property (weak, nonatomic) IBOutlet UILabel *labelCellHeader;
@property (weak, nonatomic) IBOutlet UILabel *labelCellDate;
@property (weak, nonatomic) IBOutlet UITextView *textViewCellContent;

@end
