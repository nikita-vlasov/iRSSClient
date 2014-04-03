//
//  LeftModel.m
//  iRSSClient
//
//  Created by Alex on 4/4/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "LeftModel.h"

@implementation LeftModel

+ (NSMutableArray *)createLeftMenu {
    NSMutableArray *array = [[NSMutableArray alloc] init];

    [array addObject:@{@"key"   : @"Dashboard",
                       @"title" : NSLocalizedString(@"Dashboard", nil),
                       @"icon"  : @"icon_home.png"}];

    [array addObject:@{@"key"   : @"Channel",
                       @"title" : NSLocalizedString(@"Channel", nil),
                       @"icon"  : @"icon_channel.png"}];

    [array addObject:@{@"key"   : @"Setting",
                       @"title" : NSLocalizedString(@"Setting", nil),
                       @"icon"  : @"icon_settings.png"}];

    NSMutableArray *arrayObject = [[NSMutableArray alloc] init];
    for (LeftModel *leftMenu in array) {
        [arrayObject addObject:leftMenu];
    }

    return arrayObject;
}

@end
