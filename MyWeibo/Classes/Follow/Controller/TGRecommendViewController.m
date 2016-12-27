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
#import "TGRecommendCategoryCell.h"
#import <MJExtension.h>
#import "TGRecommendCategory.h"

@interface TGRecommendViewController () <UITableViewDataSource, UITableViewDelegate>

// Data of left recommendation category part
@property (nonatomic, strong) NSArray *categories;
// Table of left recommendation category part
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;

@end

@implementation TGRecommendViewController

static NSString *const TGCategoryId = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Register
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TGRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:TGCategoryId];
    
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
        
        // JSON data returned by server
        self.categories = [TGRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // Reload table
        [self.categoryTableView reloadData];
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

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TGRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:TGCategoryId];
    
    cell.category = self.categories[indexPath.row];
    
    return cell;
}

@end
