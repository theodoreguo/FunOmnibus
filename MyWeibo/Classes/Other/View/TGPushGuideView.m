//
//  TGPushGuideView.m
//  MyWeibo
//
//  Created by Theodore Guo on 1/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGPushGuideView.h"

@implementation TGPushGuideView

+ (instancetype)guideView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

+ (void)show {
    NSString *key = @"CFBundleShortVersionString";
    
    // Get current version
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    // Get version stored in sandbox
    NSString *sandboxVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    if (![currentVersion isEqualToString:sandboxVersion]) {
        UIWindow *window = [UIApplication sharedApplication].keyWindow;
        
        // Show push guide view
        TGPushGuideView *guideView = [TGPushGuideView guideView];
        guideView.frame = window.bounds;
        [window addSubview:guideView];
        
        // Store version
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)understood {
    [self removeFromSuperview];
}

@end
