#import "ChannelView.h"

@implementation ChannelView

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

- (UIBarButtonItem *)barButtonOpenChannel {
    if (!_barButtonOpenChannel) {
        _barButtonOpenChannel = [[UIBarButtonItem alloc] init];
    }
    return _barButtonOpenChannel;
}

@end
