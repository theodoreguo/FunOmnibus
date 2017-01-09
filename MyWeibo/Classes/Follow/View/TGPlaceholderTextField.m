//
//  TGPlaceholderTextField.m
//  MyWeibo
//
//  Created by Theodore Guo on 31/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGPlaceholderTextField.h"
#import "objc/runtime.h"

static NSString * const TGPlaceholderColorKeyPath = @"_placeholderLabel.textColor";

@implementation TGPlaceholderTextField

/*
- (void)drawPlaceholderInRect:(CGRect)rect {
    [self.placeholder drawInRect:CGRectMake(0, 10, rect.size.width, 25) withAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor], NSFontAttributeName: self.font}];
}
 */

/*
+ (void)initialize {
    unsigned int count = 0;
    
    // Copy the list of all instance variables
    Ivar *ivars = class_copyIvarList([UITextField class], &count);
    
    for (int i = 0; i < count; i++) {
        // Get instance variables
//        Ivar ivar = *(ivars + i);
        Ivar ivar = ivars[i];
        
        // Print variables' names
        TGLog(@"%s", ivar_getName(ivar));
    }
    
    // Free
    free(ivars);
}
 */

- (void)awakeFromNib {
    // Set cursor color same as text color
    self.tintColor = self.textColor;
    
    // Resign first responder
    [self resignFirstResponder];
}

/**
 *  Invoked when text field gets focus
 *
 *  @return become first responder
 */
- (BOOL)becomeFirstResponder {
    // Set placeholder text color
    [self setValue:self.textColor forKeyPath:TGPlaceholderColorKeyPath];
    return [super becomeFirstResponder];
}

/**
 *  Invoked when text field loses focus
 *
 *  @return resign first responder
 */
- (BOOL)resignFirstResponder {
    // Set placeholder text color
    [self setValue:[UIColor grayColor] forKeyPath:TGPlaceholderColorKeyPath];
    return [super resignFirstResponder];
}

/*
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    _placeholderColor = placeholderColor;
    
    // Set placeholder text color
    [self setValue:placeholderColor forKeyPath:TGPlaceholderColorKeyPath];
}
*/

@end
