//
//  TGFollowViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 23/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGFollowViewController.h"
#import "TGRecommendViewController.h"
#import "TGLoginRegisterViewController.h"

@interface TGFollowViewController ()

@end

@implementation TGFollowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set navigation bar content
    // Set navigation bar title
    self.navigationItem.title = @"My Following";
    
    // Set navigation bar left button
    /*
    UIButton *followButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [followButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon"] forState:UIControlStateNormal];
    [followButton setBackgroundImage:[UIImage imageNamed:@"friendsRecommentIcon-click"] forState:UIControlStateHighlighted];
    followButton.size = followButton.currentBackgroundImage.size;
    [followButton addTarget:self action:@selector(followClick) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:followButton];
    */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"friendsRecommentIcon" highlightedImage:@"friendsRecommentIcon-click" target:self action:@selector(followClick)];
    
    // Set background color
    self.view.backgroundColor = TGGlobalBackgroundColor;
}

- (void)followClick {
    TGRecommendViewController *vc = [[TGRecommendViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginRegister {
    TGLoginRegisterViewController *login = [[TGLoginRegisterViewController alloc] init];
    [self presentViewController:login animated:YES completion:nil];
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UIViewController *vc = [[UIViewController alloc] init];
    vc.view.backgroundColor = TGRGBColor(200, 100, 50);
    [self.navigationController pushViewController:vc animated:YES];
}
*/

@end
