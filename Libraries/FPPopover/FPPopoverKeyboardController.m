//
//  FPPopoverKeyboardController.m
//  iRSSClient
//
//  Created by Alex on 4/6/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "FPPopoverKeyboardController.h"

@interface FPPopoverKeyboardController ()

@end

@implementation FPPopoverKeyboardController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)parentHeight {
    return _parentView.bounds.size.height - self.keyboardHeight;
}

@end
