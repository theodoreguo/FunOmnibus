//
//  UIBarButtonItem+TGExtension.m
//  MyWeibo
//
//  Created by Theodore Guo on 25/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "UIBarButtonItem+TGExtension.h"

@implementation UIBarButtonItem (TGExtension)

+ (instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightedImage] forState:UIControlStateHighlighted];
    button.size = button.currentBackgroundImage.size;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // self == UIBarButtonItem
    return [[self alloc] initWithCustomView:button];
}

@end
