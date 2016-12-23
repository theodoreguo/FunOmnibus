//
//  TGTabBarController.m
//  MyWeibo
//
//  Created by Theodore Guo on 23/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGTabBarController.h"

@interface TGTabBarController ()

@end

@implementation TGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add child controller
    // Essence
    UIViewController *vc01 = [[UIViewController alloc] init];
    vc01.tabBarItem.title = @"Essence";
    vc01.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc01.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    [vc01.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [vc01.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    vc01.view.backgroundColor = [UIColor redColor];
    [self addChildViewController: vc01];
    
    // Latest
    UIViewController *vc02 = [[UIViewController alloc] init];
    vc02.tabBarItem.title = @"Latest";
    vc02.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc02.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    
    [vc02.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [vc02.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    vc02.view.backgroundColor = [UIColor grayColor];
    [self addChildViewController: vc02];
    
    // Follow
    UIViewController *vc03 = [[UIViewController alloc] init];
    vc03.tabBarItem.title = @"Follow";
    vc03.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc03.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    
    [vc03.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [vc03.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    vc03.view.backgroundColor = [UIColor greenColor];
    [self addChildViewController: vc03];
    
    // Me
    UIViewController *vc04 = [[UIViewController alloc] init];
    vc04.tabBarItem.title = @"Me";
    vc04.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc04.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    
    [vc04.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [vc04.tabBarItem setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    vc04.view.backgroundColor = [UIColor blueColor];
    [self addChildViewController: vc04];
}

@end
