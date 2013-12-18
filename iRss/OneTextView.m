#import "OneTextView.h"
#import "DetailViewController.h"

@interface OneTextView () {
    
}

@end


@implementation OneTextView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    fontSize = [userDefaults integerForKey:@"FONT_SIZE_DESCRIPTION"];
    [[self textViewOneText] setFont:[UIFont fontWithName:@"HelveticaNeue" size:fontSize]];
    [self reloadTextView];
}

#pragma mark - Setter
- (void)setStringText:(NSString *)stringText {
    _stringText = stringText;
}

#pragma mark - Action
- (IBAction)buttonToolbarDone:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buttonToolbarFondSizeAdd:(id)sender {
    fontSize ++;
    [self reloadTextView];
}

- (IBAction)buttonToolbarFondSizeTake:(id)sender {
    fontSize --;
    [self reloadTextView];
}

#pragma mark -
- (void)reloadTextView {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:fontSize forKey:@"FONT_SIZE_DESCRIPTION"];
    [userDefaults synchronize];
    
    [[self textViewOneText] setFont:[UIFont fontWithName:@"HelveticaNeue" size:fontSize]];
    [[self textViewOneText] setText:_stringText];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
