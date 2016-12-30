//
//  TGRecommendTagViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 30/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGRecommendTagViewController.h"
#import "TGRecommendTag.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "TGRecommendTagCell.h"

@interface TGRecommendTagViewController ()

// Tags data
@property (nonatomic, strong) NSArray *tags;

@end

static NSString *const TGTagId = @"tag";

@implementation TGRecommendTagViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up table view
    [self setUpTableView];
    
    // Load recommended tags
    [self loadTags];
}

/**
 *  Initialization
 */
- (void)setUpTableView{
    // Set title
    self.title = @"Recommended Tags";
    
    // Register
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TGRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:TGTagId];
    
    // Set cell height
    self.tableView.rowHeight = 70;
    
    // Remove default cell separator
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Set table view background color
    self.tableView.backgroundColor = TGGlobalBackgroundColor;
}

/**
 *  Load recommended tags
 */
-(void)loadTags {
    // Show HUD
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD show];
    
    // Request parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    
    // Send request
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, id responseObject) {
        // Hide HUD
        [SVProgressHUD dismiss];
        
        // JSON data returned by server
        self.tags = [TGRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        
        // Reload table
        [self.tableView reloadData];
        
        //        // Set first line selected by default
        //        [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
        //
        //        // Make users table start drag-down refreshing status
        //        [self.userTableView.mj_header beginRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // Show failure reminder
        [SVProgressHUD showErrorWithStatus:@"Loading recommendation info failed"];
    }];
#pragma clang diagnostic pop
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tags.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TGRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:TGTagId];
    
    cell.recommendTag = self.tags[indexPath.row];

    return cell;
}

@end
