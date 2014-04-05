//
//  TextView.h
//  iRSSClient
//
//  Created by Alex on 4/5/14.
//  Copyright (c) 2014 Alex. All rights reserved.
//

#import "TextFieldCell.h"
#import <UIKit/UIKit.h>

@interface TextViewCell : TextFieldCell

#pragma mark - UITextView
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end
