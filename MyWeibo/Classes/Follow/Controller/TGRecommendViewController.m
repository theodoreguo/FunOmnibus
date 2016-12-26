//
//  TGRecommendViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 26/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>

@interface TGRecommendViewController ()

@end

@implementation TGRecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set title
    self.title = @"Recommendations";
    
    // Set background color
    self.view.backgroundColor = TGGlobalBackgroundColor;
    // Show HUD
    [SVProgressHUD show];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // Send requests
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    #pragma clang diagnostic push
    #pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        // Hide HUD
        [SVProgressHUD dismiss];
        TGLog(@"%@", responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // Show failure reminder
        [SVProgressHUD showErrorWithStatus:@"Loading recommendation info failed"];
    }];
    #pragma clang diagnostic pop
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
