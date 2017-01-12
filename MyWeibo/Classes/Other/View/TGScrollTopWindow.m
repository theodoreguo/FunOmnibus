//
//  TGScrollTopWindow.m
//  MyWeibo
//
//  Created by Theodore Guo on 11/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGScrollTopWindow.h"

@implementation TGScrollTopWindow

// Global variable
static UIWindow *window_;

+ (void)initialize {
    window_ = [[UIWindow alloc] init];
    window_.frame = CGRectMake(0, 0, TGScreenW, 20);
    window_.windowLevel = UIWindowLevelAlert;
    [window_ addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(windowClick)]];
}

+ (void)show {
    window_.hidden = NO;
}

+ (void)hide {
    window_.hidden = YES;
}

/**
 *  Monitor window click event
 */
+ (void)windowClick {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [self searchScrollViewInView:window];
}

/**
 *  Recursive invocation to search for scroll view
 */
+ (void)searchScrollViewInView:(UIView *)superview {
    for (UIScrollView *subview in superview.subviews) {
        // If the widget is scroll view and showing in the window, view will scroll back to the most top part
        if ([subview isKindOfClass:[UIScrollView class]] && subview.isShowingInKeyWindow) {
            CGPoint offset = subview.contentOffset;
            offset.y = - subview.contentInset.top;
            [subview setContentOffset:offset animated:YES];
        }
        
        [self searchScrollViewInView:subview]; // Recursive call to search
    }
}

@end
