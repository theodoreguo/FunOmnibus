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
#import <MJRefresh.h>

// Selected category model of left part
//TGRecommendCategory *c = self.categories[self.categoryTableView.indexPathForSelectedRow.row];
#define TGSelectedCategory self.categories[self.categoryTableView.indexPathForSelectedRow.row]

@interface TGRecommendViewController () <UITableViewDataSource, UITableViewDelegate>

// Data of left recommendation category part
@property (nonatomic, strong) NSArray *categories;
//// Data of right recommended users part
//@property (nonatomic, strong) NSArray *users;

// Table of left recommendation category part
@property (weak, nonatomic) IBOutlet UITableView *categoryTableView;
// Table of right recommended users part
@property (weak, nonatomic) IBOutlet UITableView *userTableView;

// Request parameters
@property (nonatomic, strong) NSMutableDictionary *params;

// AFN request manager
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation TGRecommendViewController

static NSString *const TGCategoryId = @"category";
static NSString *const TGUserId = @"user";

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialization
    [self setUpTableView];
    
    // Add refresh widget
    [self setupRefresh];

    // Load data of left recommendation category part
    [self loadCategories];
}

/**
 *  Load data of left recommendation category part
 */
- (void)loadCategories {
    // Show HUD
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    // Send request to load left part data
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        // Hide HUD
        [SVProgressHUD dismiss];
        
        // JSON data returned by server
        self.categories = [TGRecommendCategory mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // Reload table
        [self.categoryTableView reloadData];
        
        // Set first line selected by default
        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        
        // Make users table start drag-down refreshing status
        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // Show failure reminder
        [SVProgressHUD showErrorWithStatus:@"Loading recommendation info failed"];
    }];
#pragma clang diagnostic pop
}

/**
 *  Initialization
 */
- (void)setUpTableView {
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

/**
 *  Add refresh widget
 */
- (void)setupRefresh {
    self.userTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewUsers)];
    
    self.userTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.userTableView.mj_footer.hidden = YES;
}

#pragma mark - Load user data
- (void)loadNewUsers {
    TGRecommendCategory *rc = TGSelectedCategory;
    
    // Set current page number equal to 1
    rc.currentPageNumber = 1;
    
    // Send request to load right part data
    // Request parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(rc.id);
    params[@"page"] = @(rc.currentPageNumber);
    self.params = params;
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        //                    TGLog(@"%@", responseObject[@"list"]);
        // JSON data returned by server, dictionary array -> model array
        NSArray *users = [TGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // Clear all old data
        [rc.users removeAllObjects];
        
        // Add to user array corresponding to this category
        [rc.users addObjectsFromArray:users];
        
        // Archive total users count
        rc.total = [responseObject[@"total"] integerValue];
        
        // Judge whether it's the last request
        if (self.params != params) {
            return;
        }
        
        // Reload table
        [self.userTableView reloadData];
        
        // End refreshing
        [self.userTableView.mj_header endRefreshing];
        
        // Make footer end refreshing
        [self checkFooterStatus];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // Judge whether it's the last request
        if (self.params != params) {
            return;
        }
        
        // Show failure reminder
        [SVProgressHUD showErrorWithStatus:@"Loading users data failed"];
        
        // End refreshing
        [self.userTableView.mj_header endRefreshing];
    }];
#pragma clang diagnostic pop
}

- (void)loadMoreUsers {
    TGRecommendCategory *category = TGSelectedCategory;
    
    // Send request to load right part data
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.currentPageNumber);
    self.params = params;
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        // JSON data returned by server, dictionary array -> model array
        NSArray *users = [TGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // Add to user array corresponding to this category
        [category.users addObjectsFromArray:users];
        
        // Judge whether it's the last request
        if (self.params != params) {
            return;
        }
        
        // Reload table
        [self.userTableView reloadData];
        
        // Make footer end refreshing
        [self checkFooterStatus];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // Judge whether it's the last request
        if (self.params != params) {
            return;
        }
        
        // Show failure reminder
        [SVProgressHUD showErrorWithStatus:@"Loading users data failed"];

        // End refreshing
        [self.userTableView.mj_footer endRefreshing];
    }];
#pragma clang diagnostic pop
}

/**
 *  Monitor footer status constantly
 */
- (void)checkFooterStatus {
    TGRecommendCategory *rc = TGSelectedCategory;
    
    // Control footer to show or hide once refreshing right table data
    self.userTableView.mj_footer.hidden = (rc.users.count == 0);
    
    // Make footer end refreshing
    if (rc.users.count == rc.total) { // All data have been loaded
        [self.userTableView.mj_footer endRefreshingWithNoMoreData];
    } else { // Data haven't been loaded completely
        [self.userTableView.mj_footer endRefreshing];
    }
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { // Judge whether current categroy needs to load more users data once being selected
    // Left category table
    if (tableView == self.categoryTableView) {
        return self.categories.count;
    }
 
    // Monitor footer status
    [self checkFooterStatus];
    
    // Right user table
    return [TGSelectedCategory users].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.categoryTableView) { // Left category table
        TGRecommendCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:TGCategoryId];
        cell.category = self.categories[indexPath.row];
        return cell;
    } else { // Right user table
        TGRecommendUserCell *cell = [tableView dequeueReusableCellWithIdentifier:TGUserId];
        cell.user = [TGSelectedCategory users][indexPath.row];
        return cell;
    }
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    // End refreshing
    [self.userTableView.mj_header endRefreshing];
    [self.userTableView.mj_footer endRefreshing];
     */
    
    TGRecommendCategory *c = self.categories[indexPath.row];
    
    if (c.users.count) {
        // Show data loaded
        [self.userTableView reloadData];
    } else {
        // Refresh table to user data of current category immediately in order to avoid showing remaining user data of last category when switching between different categories
        [self.userTableView reloadData];
        
        // Begin drag-down refreshing status
        [self.userTableView.mj_header beginRefreshing];
        
        /*
        // Set current page number equal to 1
        c.currentPageNumber = 1;
         
//        // Delay simulation
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        
//        });
        
        // Send requests to load right part data
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        params[@"page"] = @(c.currentPageNumber);
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
//                    TGLog(@"%@", responseObject[@"list"]);
            // JSON data returned by server, dictionary array -> model array
            NSArray *users = [TGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            // Add to user array corresponding to this category
            [c.users addObjectsFromArray:users];
            
            // Archive total users count
            c.total = [responseObject[@"total"] integerValue];

            // Reload table
            [self.userTableView reloadData];
            
            if (c.users.count == c.total) { // Judge whether all data are loaded or not
                [self.userTableView.mj_footer endRefreshingWithNoMoreData];
            }
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            TGLog(@"%@", error);
        }];
#pragma clang diagnostic pop
         */
    }
}

#pragma mark - Destroy controller
- (void)dealloc {
    // End all operations
    [self.manager.operationQueue cancelAllOperations];
}

@end
