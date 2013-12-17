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

#pragma mark -
- (void)reloadTextView {
    [[self textViewOneText] setText:_stringText];
}

#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
