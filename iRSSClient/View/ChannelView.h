#import <UIKit/UIKit.h>

@interface ChannelView : UIView

#pragma mark - UIBarButtonItem
@property (weak, nonatomic) IBOutlet UIBarButtonItem *leftBarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *rightBarButton;

#pragma mark - UITableView
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) UIBarButtonItem *barButtonOpenChannel;

@end
