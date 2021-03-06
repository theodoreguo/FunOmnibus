//
//  TGMeViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 23/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGMeViewController.h"
#import "TGMeCell.h"
#import "TGMeFooterView.h"

@interface TGMeViewController ()

@end

@implementation TGMeViewController

static NSString *TGMeId = @"me";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set navigation bar content
    [self setUpNavi];
    
    // Set table view
    [self setUpTableView];
}

/**
 *  Set navigation bar content
 */
- (void)setUpNavi {
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
}

/**
 *  Set table view
 */
- (void)setUpTableView {
    // Set background color
    self.tableView.backgroundColor = TGGlobalBackgroundColor;
    
    // Register table view cell
    [self.tableView registerClass:[TGMeCell class] forCellReuseIdentifier:TGMeId];
    
    // Remove default separator
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Adjust table view's header and footer
    self.tableView.sectionHeaderHeight = 0;
    self.tableView.sectionFooterHeight = TGPostCellMargin;
    
    // Adjust inset paddding to move up entirely
    self.tableView.contentInset = UIEdgeInsetsMake(TGPostCellMargin - 35, 0, 0, 0);
    
    // Set footer view
    self.tableView.tableFooterView = [[TGMeFooterView alloc] init];
}

- (void)settingClick {
    TGLogFunc;
}

- (void)nightModeClick {
    TGLogFunc;
}

#pragma mark - Data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TGMeCell *cell = [tableView dequeueReusableCellWithIdentifier:TGMeId];
    
    if (indexPath.section == 0) {
        cell.imageView.image = [UIImage imageNamed:@"setup-head-default"];
        cell.textLabel.text = @"Login / Sign Up";
    } else if (indexPath.section == 1) {
        cell.imageView.image = [UIImage imageNamed:@"publish-offline"];
        cell.textLabel.text = @"Download";
    }
        
    return cell;
}

@end
