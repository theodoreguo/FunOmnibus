//
//  TGTabBar.m
//  MyWeibo
//
//  Created by Theodore Guo on 25/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGTabBar.h"
#import "TGPublishViewController.h"

@interface TGTabBar ()

// publishButton
@property (nonatomic, weak) UIButton *publishButton;

@end

@implementation TGTabBar

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Set tabBar background image
        [self setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];

        // Add publish button
        UIButton *publishButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [publishButton setBackgroundImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateSelected];
        [publishButton addTarget:self action:@selector(publishClick) forControlEvents:UIControlEventTouchUpInside];
        publishButton.size = publishButton.currentBackgroundImage.size;
        [self addSubview:publishButton];
        self.publishButton = publishButton;
    }
    
    return self;
}

- (void)publishClick {
    TGPublishViewController *publish = [[TGPublishViewController alloc] init];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:publish animated:NO completion:nil];
}
         
- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.width;
    CGFloat height = self.height;
    
    // Set publishButton's frame
    /*
    self.publishButton.width = self.publishButton.currentBackgroundImage.size.width;
    self.publishButton.height = self.publishButton.currentBackgroundImage.size.height;
    self.publishButton.size = self.publishButton.currentBackgroundImage.size;
    */
    self.publishButton.center = CGPointMake(width * 0.5, height * 0.5);
    
    /*
    self.publishButton.bounds = CGRectMake(0, 0, self.publishButton.currentBackgroundImage.size.width, self.publishButton.currentBackgroundImage.size.height);
    self.publishButton.center = CGPointMake(self.frame.size.width * 0.5, self.frame.size.height * 0.5);
    */
    
    // Set other UITabBarButton's frame
    CGFloat buttonY = 0;
//    CGFloat buttonW = self.frame.size.width / 5;
    CGFloat buttonW = width / 5;
    
//    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonH = height;
    
    NSInteger index = 0;
    
    for (UIView *button in self.subviews) {
        /*
        if (![button isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            continue;
        }
        */
        if (![button isKindOfClass:[UIControl class]] || button == self.publishButton) {
            continue;
        }
        // Calculate button's x value
        CGFloat buttonX = buttonW * ((index > 1)?(index + 1):index);
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // Increase index
        index++;
    }
}

@end
