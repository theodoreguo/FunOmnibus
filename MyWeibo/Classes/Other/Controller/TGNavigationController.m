//
//  TGNavigationController.m
//  MyWeibo
//
//  Created by Theodore Guo on 26/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGNavigationController.h"

@interface TGNavigationController ()

@end

@implementation TGNavigationController

/**
 *  Called when the class is used the first time
 */
+ (void)initialize {
    // Appearance will take effect only when navigation bar controller is used in TGNavigationController
    //    UINavigationBar *bar = [UINavigationBar appearanceWhenContainedIn:[self class], nil];
    UINavigationBar *bar = [UINavigationBar appearance];
    [bar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}


/**
 *  Intercept all pushed controllers using this method
 *
 *  @param viewController viewController
 *  @param animated       animated
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) { // If the pushed controller is not the first one
        //    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil action:nil];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"Back" forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
        button.size = CGSizeMake(70, 30);
//        [button sizeToFit];
//        button.backgroundColor = [UIColor blueColor];
        
        // Make button content move outside of its default region
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
        
        // Set button content left-aligned
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        
        // Monitor button click event
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        
        // Hide tabBar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // Ensure viewController can override the leftBarButtonItem set up above
    [super pushViewController:viewController animated:animated];
}

- (void)back {
    [self popViewControllerAnimated:YES];
}

@end
