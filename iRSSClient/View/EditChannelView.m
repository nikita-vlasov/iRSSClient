#import "EditChannelView.h"

@implementation EditChannelView

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

- (UIBarButtonItem *)barButtonSave {
    if (!_barButtonSave) {
        _barButtonSave = [[UIBarButtonItem alloc] init];
    }
    return _barButtonSave;
}

- (UIAlertView *)alertViewAction {
    if (!_alertViewAction) {
        _alertViewAction = [[UIAlertView alloc] init];
    }
    return _alertViewAction;
}

@end
