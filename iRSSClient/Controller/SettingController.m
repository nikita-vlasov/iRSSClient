//
//  SettingController.m
//  iRSSClient
//
//  Created by Alex on 4/2/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "SettingController.h"
#import "SettingView.h"

@interface SettingController ()

/** View */
@property (strong, nonatomic) IBOutlet SettingView *SettingView;

@end


@implementation SettingController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
