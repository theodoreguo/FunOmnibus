//
//  TGPublishViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 8/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGPublishViewController.h"
#import "TGVerticalButton.h"

@interface TGPublishViewController ()

@end

@implementation TGPublishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add slogan
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    sloganView.y = TGScreenH * 0.2;
    sloganView.centerX = TGScreenW * 0.5;
    [self.view addSubview:sloganView];
    
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
        
        // Set content
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        
        // Set frame
        button.width = buttonW;
        button.height = buttonH;
        int row =  i / maxCols;
        int col = i % maxCols;
        button.x = buttonStartX + col * (buttonW + buttonMargin);
        button.y = buttonStartY + row * buttonH;
        
        [self.view addSubview:button];
    }
}

- (IBAction)cancel {
    [self dismissViewControllerAnimated:NO completion:nil];
}

@end
