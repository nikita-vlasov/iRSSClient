//
//  LeftModel.h
//  iRSSClient
//
//  Created by Alex on 4/4/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LeftModel : NSObject

#pragma mark - NSString
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *icon;
@property (strong, nonatomic) NSString *key;

#pragma mark - Other
+ (NSMutableArray *)createLeftMenu;

@end
