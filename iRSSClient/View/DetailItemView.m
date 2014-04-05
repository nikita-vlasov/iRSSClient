#import "DetailItemView.h"

@implementation DetailItemView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {}
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (UIActionSheet *)actionSheetShare {
    if (!_actionSheetShare) _actionSheetShare = [[UIActionSheet alloc] init];
    return _actionSheetShare;
}

@end
