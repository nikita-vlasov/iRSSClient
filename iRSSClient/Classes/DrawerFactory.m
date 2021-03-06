#import "DrawerFactory.h"
#import "MMDrawerVisualState.h"

@interface DrawerFactory ()

@property MMDrawerController *drawerController;

#pragma mark - UIViewController
@property (strong, nonatomic) LeftController *left;
@property (strong, nonatomic) DashboardController *dashboard;
@property (strong, nonatomic) ChannelController *channel;
@property (strong, nonatomic) SettingController *setting;

#pragma mark - UIStoryboard
@property (strong, nonatomic) UIStoryboard *storyboard;

@end


@implementation DrawerFactory

#pragma mark -
+ (DrawerFactory *)sharedFactory {
    static DrawerFactory *factory = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        factory = [[DrawerFactory alloc] init];
    });

    return factory;
}

- (id)init {
    self = [super init];
    if (self) {
        _storyboard = [UIStoryboard storyboardWithName:@"iPhone" bundle:nil];
    }
    return self;
}

- (void)createLeftMenu {
    _left = [[self storyboard] instantiateViewControllerWithIdentifier:@"Left"];
    _dashboard = [[self storyboard] instantiateViewControllerWithIdentifier:@"Dashboard"];
    _channel = [[self storyboard] instantiateViewControllerWithIdentifier:@"Channel"];
    _setting = [[self storyboard] instantiateViewControllerWithIdentifier:@"Setting"];

    _drawerController = [[MMDrawerController alloc] initWithCenterViewController:_dashboard
                                                        leftDrawerViewController:_left
                                                       rightDrawerViewController:nil];

    [_drawerController setDrawerVisualStateBlock:[MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0f]];
    [_drawerController setMaximumLeftDrawerWidth:200.0f];
    [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
}

- (void)removeAllControllers {
    _left = nil;
    _dashboard = nil;
    _channel = nil;
    _setting = nil;
}

#pragma mark - Getters
- (MMDrawerController *)drawerViewController {
    return _drawerController;
}

- (LeftController *)leftController {
    return _left;
}

- (DashboardController *)dashboardController {
    return _dashboard;
}

- (ChannelController *)channelController {
    return _channel;
}

- (SettingController *)settingController {
    return _setting;
}

@end
