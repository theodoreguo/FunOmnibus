//
//  TGPublishViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 8/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGPublishViewController.h"
#import "TGVerticalButton.h"
#import <pop.h>

static CGFloat const TGAnimationInterval = 0.1;
static CGFloat const TGSpringFactor = 10;

@interface TGPublishViewController ()

@end

@implementation TGPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Disable user interaction during view is loading
    self.view.userInteractionEnabled = NO;
    
    // Add six buttons
    // Buttons' insets
    NSArray *images = @[@"publish-video", @"publish-audio", @"publish-picture", @"publish-text", @"publish-review", @"publish-offline"];
    NSArray *titles = @[@"Video", @"Audio", @"Picture", @"Joke", @"Review", @"Download"];
    
    int maxCols = 3;
    CGFloat buttonW = 72;
    CGFloat buttonH = buttonW + 30;
    CGFloat buttonStartY = (TGScreenH - 2 * buttonH) * 0.5;
    CGFloat buttonStartX = 20;
    CGFloat buttonMargin = (TGScreenW - 2 * buttonStartX - maxCols * buttonW) / (maxCols - 1); // It's the margin between every two buttons
    for (int i = 0; i < images.count; i++) {
        TGVerticalButton *button = [[TGVerticalButton alloc] init];
        button.tag = i;
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        // Set content
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // Calculate x/y
        int row =  i / maxCols;
        int col = i % maxCols;
        CGFloat buttonX = buttonStartX + col * (buttonW + buttonMargin);
        CGFloat buttonEndY = buttonStartY + row * buttonH;
        CGFloat buttonBeginY = buttonEndY - TGScreenH;
        
        // Add buttons' animation
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonBeginY, buttonW, buttonH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(buttonX, buttonEndY, buttonW, buttonH)];
        anim.springBounciness = TGSpringFactor;
        anim.springSpeed = TGSpringFactor;
        anim.beginTime = CACurrentMediaTime() + TGAnimationInterval * i;
        [button pop_addAnimation:anim forKey:nil];
    }
    
    // Add slogan
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    
    // Add slogan's animation
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    CGFloat centerX = TGScreenW * 0.5;
    CGFloat centerEndY = TGScreenH * 0.2;
    CGFloat centerBeginY = centerEndY - TGScreenH;
    sloganView.centerX = centerX;
    sloganView.centerY = centerBeginY;
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerBeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerEndY)];
    anim.springBounciness = TGSpringFactor;
    anim.springSpeed = TGSpringFactor;
    anim.beginTime = CACurrentMediaTime() + images.count * TGAnimationInterval;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // Resume user interaction after slogan animation is completed
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
}

- (void)buttonClick:(UIButton *)button {
    [self cancelWithCompletionBlock:^{
        switch (button.tag) {
            case 0:
//                TGLog(@"Video");
                break;
                
            case 1:
//                TGLog(@"Audio");
                break;
                
            case 2:
//                TGLog(@"Picture");
                break;
                
            case 3:
//                TGLog(@"Joke");
                break;
                
            case 4:
//                TGLog(@"Review");
                break;
                
            case 5:
//                TGLog(@"Download");
                break;
                
            default:
                break;
        }
    }];
}

- (IBAction)cancel {
    [self cancelWithCompletionBlock:nil];
}

/**
 *  Implement dismissing animation, followed by completionBlock
 */
- (void)cancelWithCompletionBlock:(void (^)())completionBlock {
    // Disable user interaction during view is being dimissed
    self.view.userInteractionEnabled = NO;
    
    int beginIndex = 2;
    
    for (int i = beginIndex; i < self.view.subviews.count; i++) {
        UIView *subView = self.view.subviews[i];
        
        POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPViewCenter];
        CGFloat centerY = subView.centerY + TGScreenH;
        
        // Set animation pace to begin slowly and then speed up as it progresses
        anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
        
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(subView.centerX, centerY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * TGAnimationInterval;
        [subView pop_addAnimation:anim forKey:nil];
        
        // Monitor the last animation to dismiss the view controller
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                [self dismissViewControllerAnimated:NO completion:nil];
                
                // Execute arg completionBlock
                !completionBlock ? : completionBlock();
            }];
        }
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self cancelWithCompletionBlock:nil];
}

@end
