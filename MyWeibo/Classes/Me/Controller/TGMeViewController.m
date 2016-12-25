//
//  TGMeViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 23/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGMeViewController.h"

@interface TGMeViewController ()

@end

@implementation TGMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    /// Set navigation bar content
    // Set navigation bar title
    self.navigationItem.title = @"Me";
    
    // Set navigation bar right buttons
    /*
    UIButton *settingButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon"] forState:UIControlStateNormal];
    [settingButton setBackgroundImage:[UIImage imageNamed:@"mine-setting-icon-click"] forState:UIControlStateHighlighted];
    settingButton.size = settingButton.currentBackgroundImage.size;
    [settingButton addTarget:self action:@selector(settingClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *nightModeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nightModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon"] forState:UIControlStateNormal];
    [nightModeButton setBackgroundImage:[UIImage imageNamed:@"mine-moon-icon-click"] forState:UIControlStateHighlighted];
    nightModeButton.size = nightModeButton.currentBackgroundImage.size;
    [nightModeButton addTarget:self action:@selector(nightModeClick) forControlEvents:UIControlEventTouchUpInside];
    */
    UIBarButtonItem *settingItem = [UIBarButtonItem itemWithImage:@"mine-setting-icon" highlightedImage:@"mine-setting-icon-click" target:self action:@selector(settingClick)];
     UIBarButtonItem *nightModeItem = [UIBarButtonItem itemWithImage:@"mine-moon-icon" highlightedImage:@"mine-moon-icon-click" target:self action:@selector(nightModeClick)];
    
    self.navigationItem.rightBarButtonItems = @[settingItem, nightModeItem];
    
    // Set background color
    self.view.backgroundColor = TGGlobalBackgroundColor;
}

- (void)settingClick
{
    TGLogFunc;
}

- (void)nightModeClick
{
    TGLogFunc;
}

@end
