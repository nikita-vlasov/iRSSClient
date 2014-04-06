#import "FontSizeController.h"
#import "FontSizeView.h"

@interface FontSizeController ()

/** View. */
@property (strong, nonatomic) IBOutlet FontSizeView *fontSizeView;

@end


@implementation FontSizeController

#pragma mark - UIViewController
- (void)viewDidLoad {
    [super viewDidLoad];

    [[[[self fontSizeView] navigationBar] topItem] setTitle:NSLocalizedString(@"Font size", nil)];

    [[[self fontSizeView] stepperButton] addTarget:self action:@selector(stepperPressed:) forControlEvents:UIControlEventValueChanged];
    [[[self fontSizeView] stepperButton] setValue:[[NSUserDefaults standardUserDefaults] doubleForKey:@"content_font_size"]];

    /* Устанавливаю минимальное значение. */
    [[[self fontSizeView] stepperButton] setMinimumValue:10.0f];
    /* Устанавливаю максимальное значение. */
    [[[self fontSizeView] stepperButton] setMaximumValue:30.0f];

    [[[self fontSizeView] labelFontSize] setFont:[UIFont fontWithName:@"Helvetica Neue" size:[[[self fontSizeView] stepperButton] value]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Button Pressed
- (void)stepperPressed:(UIStepper *)sender {
    NSLog(@"%f", [sender value]);

    [[[self fontSizeView] labelFontSize] setFont:[UIFont fontWithName:@"Helvetica Neue" size:[sender value]]];

    [[NSUserDefaults standardUserDefaults] setDouble:[sender value] forKey:@"content_font_size"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
