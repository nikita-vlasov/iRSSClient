#import <UIKit/UIKit.h>
#import "LeftView.h"

@interface ChannelView : LeftView

#pragma mark - UIBarButtonItem
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButton;


@property (strong, nonatomic) UIBarButtonItem *barButtonOpenChannel;

@end
