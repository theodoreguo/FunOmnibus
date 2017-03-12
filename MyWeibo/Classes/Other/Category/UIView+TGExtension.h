//
//  UIView+TGExtension.h
//  MyWeibo
//
//  Created by Theodore Guo on 25/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TGExtension)

// Note: Declaring @property in the category will only generate method declaration without its implementation and "_XX" member variables
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

// Judge a widget is acctually showing in the key window's range or not
- (BOOL)isShowingInKeyWindow;

@end
