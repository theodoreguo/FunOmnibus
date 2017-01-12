//
//  TGPostViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 2/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGPostViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "TGPost.h"
#import <MJExtension.h>
#import <MJRefresh.h>
#import "TGPostCell.h"
#import "TGCommentViewController.h"
#import "TGLatestViewController.h"

@interface TGPostViewController ()

// Post data
@property (nonatomic, strong) NSMutableArray *posts;
// Current page number
@property (nonatomic, assign) NSInteger page;
// Needed when loading next page data
@property (nonatomic, copy) NSString *maxtime;
// Last request parameters
@property (nonatomic, strong) NSDictionary *params;

// Last selected tab bar controller's index
@property (nonatomic, assign) NSInteger lastSelectedIndex;

@end

@implementation TGPostViewController

static NSString * const TGPostCellId = @"post";

-(NSMutableArray *)posts {
    if (!_posts) {
        _posts = [NSMutableArray array];
    }
    
    return _posts;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize table view
    [self setUpTableView];
    
    // Add refreshing widget
    [self setUpRefresh];
}

-(void) setUpTableView {
    // Set padding
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = TGTitlesViewY + TGTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // Adjust scroll bar's padding
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // Hide separator
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // Register customised cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TGPostCell class]) bundle:nil] forCellReuseIdentifier:TGPostCellId];
    
    // Monitor tab bar selection notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelect) name:TGTabBarDidSelectNotification object:nil];
}

- (void)tabBarSelect {
    // Refresh if the same tab bar controller is selected again and current tab content is showing in key window
    if (self.lastSelectedIndex == self.tabBarController.selectedIndex && self.view.isShowingInKeyWindow) {
        [self.tableView.mj_header beginRefreshing];
    }
    
    // Save current selected controller's index
    self.lastSelectedIndex = self.tabBarController.selectedIndex;
}

/**
 *  Set up refreshing
 */
- (void)setUpRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewPosts)];
    
    // Set transparence automatically
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    
    // Begin refreshing
    [self.tableView.mj_header beginRefreshing];
    
    //    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMorePosts)];
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMorePosts)];
    //    self.tableView.mj_footer.hidden = YES;
}

#pragma mark - Param 'a'

/**
 *  Judge to assign corresponding parameter for Essence and Latest parts
 */
- (NSString *)a {
    return [self.parentViewController isKindOfClass:[TGLatestViewController class]] ? @"newlist" : @"list";
}

#pragma mark - Data processing

/**
 *  Load new post data
 */
- (void)loadNewPosts {
    // End drag-up refresh
    [self.tableView.mj_footer endRefreshing];
    
    // Request parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    self.params = params;
    
    // Send request
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        // Request expired
        if (self.params != params) return;
        
        // Store maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // Convert dictionary array to model array
        self.posts = [TGPost mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        // Reload table
        [self.tableView reloadData];
        
        // End refreshing
        [self.tableView.mj_header endRefreshing];
        
        // Clear page number
        self.page = 0;
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // Request expired
        if (self.params != params) return;
        
        // End refreshing
        [self.tableView.mj_header endRefreshing];
    }];
#pragma clang diagnostic pop
}

/**
 *  Load more post data
 */
-(void)loadMorePosts {
    // End drag-down refresh
    [self.tableView.mj_header endRefreshing];
    
    // Request parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = self.a;
    params[@"c"] = @"data";
    params[@"type"] = @(self.type);
    NSInteger page = self.page + 1;
    params[@"page"] = @(page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    
    // Send request
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        // Request expired
        if (self.params != params) return;
        
        // Store maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        // Convert dictionary array to model array
        NSArray *newPosts = [TGPost mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.posts addObjectsFromArray:newPosts];
        
        // Reload table
        [self.tableView reloadData];
        
        // End refreshing
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // Request expired
        if (self.params != params) return;
        
        // End refreshing
        [self.tableView.mj_footer endRefreshing];
        
        // Resume page number
        self.page = page;
    }];
#pragma clang diagnostic pop
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.posts.count == 0);
    return self.posts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    static NSString *ID = @"cell";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //
    //    if (cell == nil) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    //    }
    
    TGPostCell *cell = [tableView dequeueReusableCellWithIdentifier:TGPostCellId];
    cell.post = self.posts[indexPath.row];
    
    //    TGJoke *post = self.posts[indexPath.row];
    //    cell.textLabel.text = post.name;
    //    cell.detailTextLabel.text = post.text;
    //    [cell.imageView sd_setImageWithURL: [NSURL URLWithString:post.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    return cell;
}

#pragma mark - Delegate method

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Fetch post model
    TGPost *post = self.posts[indexPath.row];
    
    // Return the cell height of this model
    return post.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TGCommentViewController *cmtVc = [[TGCommentViewController alloc] init];
    cmtVc.post = self.posts[indexPath.row];
    [self.navigationController pushViewController:cmtVc animated:YES];
}

@end
