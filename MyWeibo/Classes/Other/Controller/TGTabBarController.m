//
//  TGTabBarController.m
//  MyWeibo
//
//  Created by Theodore Guo on 23/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGTabBarController.h"
#import "TGEssenceViewController.h"
#import "TGLatestViewController.h"
#import "TGFollowViewController.h"
#import "TGMeViewController.h"
#import "TGTabBar.h"
#import "TGNavigationController.h"

@interface TGTabBarController ()

@end

@implementation TGTabBarController

/**
 *  Called when the class is used the first time
 */
+ (void)initialize {    
    // Set UITabBarItem text attributes via "appearance" concurrently (Only those methods with UI_APPEARANCE_SELECTOR can be set by "appearance")
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add child view controller
    // Essence
    [self setUpChildVc:[[TGEssenceViewController alloc] init] title:@"Essence" image:@"tabBar_essence_icon" seletedImage:@"tabBar_essence_click_icon"];

    // Latest
    [self setUpChildVc:[[TGLatestViewController alloc] init] title:@"Latest" image:@"tabBar_new_icon" seletedImage:@"tabBar_new_click_icon"];
    
    // Follow
    [self setUpChildVc:[[TGFollowViewController alloc] init] title:@"Follow" image:@"tabBar_friendTrends_icon" seletedImage:@"tabBar_friendTrends_click_icon"];
    
    // Me
    [self setUpChildVc:[[TGMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"Me" image:@"tabBar_me_icon" seletedImage:@"tabBar_me_click_icon"];
    
    // Alter tabBar using KVC
    [self setValue:[[TGTabBar alloc] init] forKey:@"tabBar"];
        
    /*
    // Essence
     UIViewController *vc01 = [[UIViewController alloc] init];
    vc01.tabBarItem.title = @"Essence";
    vc01.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    vc01.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_essence_click_icon"];
    
    [vc01.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
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
    */
}

/**
 *  Initialize child view controller
 *
 *  @param vc           view controller needed
 *  @param title        bar title
 *  @param image        original image
 *  @param seletedImage seleted image
 */
- (void) setUpChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image seletedImage:(NSString *)seletedImage {
    // Set text and images
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:seletedImage];
//    vc.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(100) / 100.0 green:arc4random_uniform(100) / 100.0 blue:arc4random_uniform(100) / 100.0 alpha:1.0];
    
    // Pack an navigation controller, and add it as TabBarController's child view controller
    TGNavigationController *nav = [[TGNavigationController alloc] initWithRootViewController:vc];
//    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
    [self addChildViewController:nav];
}

@end
