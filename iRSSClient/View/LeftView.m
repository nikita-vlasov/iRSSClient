#import "LeftView.h"

@implementation LeftView

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

#pragma mark - Getters
- (UIRefreshControl *)refreshControl {
    if (!_refreshControl) {
        _refreshControl = [[UIRefreshControl alloc] init];
    }
    return _refreshControl;
}

@end
