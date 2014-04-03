//
//  DataModel.h
//  iRSSClient
//
//  Created by Alex on 4/3/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
+ (DataModel *)sharedModel;

- (NSArray *)entityDataSetEnturyName:(NSString *)entityName;

@end
