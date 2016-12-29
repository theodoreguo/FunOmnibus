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
#import "TGRecommendUserCell.h"
#import "TGRecommendUser.h"

@interface TGRecommendViewController () <UITableViewDataSource, UITableViewDelegate>

// Data of left recommendation category part
@property (nonatomic, strong) NSArray *categories;
//// Data of right recommended users part
//@property (nonatomic, strong) NSArray *users;

// Table of left recommendation category part
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
// Table of right recommended users part
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

@end

@implementation TGRecommendViewController

static NSString *const TGCategoryId = @"category";
static NSString *const TGUserId = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialization
    [self setTableView];
    
    // Show HUD
    [SVProgressHUD show];
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // Send requests to load left part data
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
        
        // Set first line selected by default
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // Show failure reminder
        [SVProgressHUD showErrorWithStatus:@"Loading recommendation info failed"];
    }];
#pragma clang diagnostic pop
}

- (void)setTableView {
    // Register
    [self.categoryTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TGRecommendCategoryCell class]) bundle:nil] forCellReuseIdentifier:TGCategoryId];
    [self.userTableView registerNib:[UINib nibWithNibName:NSStringFromClass([TGRecommendUserCell class]) bundle:nil] forCellReuseIdentifier:TGUserId];
    
    // Set content inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.categoryTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.userTableView.contentInset = self.categoryTableView.contentInset;
    self.userTableView.rowHeight = 70;
    
    // Set title
    self.title = @"Recommendations";
    
    // Set background color
    self.view.backgroundColor = TGGlobalBackgroundColor;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.categoryTableView) { // Left category table
        return self.categories.count;
    } else { // Right user table
        // Selected category model of left part
        TGRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        return c.users.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) { // Left category table
        TGRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:TGCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else { // Right user table
        TGRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:TGUserId];
        TGRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
        cell.user = c.users[indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TGRecommendCategory *c = self.categories[indexPath.row];
    
    if (c.users.count) {
        // Show data loaded
        [self.userTableView reloadData];
    } else {
        // Refresh table to user data of current category immediately in order to avoid showing remaining user data of last category when switching between different categories
        [self.userTableView reloadData];
        
        /*
        // Delay simulation
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        });
        */
        
        // Send requests to load right part data
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
            //        TGLog(@"%@", responseObject[@"list"]);
            // JSON data returned by server, dictionary array -> model array
            NSArray *users = [TGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            // Add to user array corresponding to this category
            [c.users addObjectsFromArray:users];

            // Reload table
            [self.userTableView reloadData];
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            TGLog(@"%@", error);
        }];
#pragma clang diagnostic pop
        
    }
}

@end
