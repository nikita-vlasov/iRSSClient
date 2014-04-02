//
//  DashboardController.m
//  iRSSClient
//
//  Created by Alex on 4/2/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "DashboardController.h"
#import "DashboardView.h"

@interface DashboardController ()

@property (strong, nonatomic) IBOutlet DashboardView *dashboardView;

@end


@implementation DashboardController

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
