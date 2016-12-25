//
//  UIBarButtonItem+TGExtension.h
//  MyWeibo
//
//  Created by Theodore Guo on 25/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (TGExtension)

+ (instancetype)itemWithImage:(NSString *)image highlightedImage:(NSString *)highlightedImage target:(id)target action:(SEL)action;

@end
