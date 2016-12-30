//
//  TGEssenceViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 23/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGEssenceViewController.h"
#import "TGTestViewController.h"
#import "TGRecommendTagViewController.h"

@interface TGEssenceViewController ()

@end

@implementation TGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set navigation bar content
    // Set navigation bar title
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // Set navigation bar left button
    /*
    UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
    [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
    tagButton.size = tagButton.currentBackgroundImage.size;
    [tagButton addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tagButton];
    */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // Set background color
    self.view.backgroundColor = TGGlobalBackgroundColor;
}

- (void)tagClick {
    TGRecommendTagViewController *tag = [[TGRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:tag animated:YES];
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    TGTestViewController *vc = [[TGTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
*/

@end
