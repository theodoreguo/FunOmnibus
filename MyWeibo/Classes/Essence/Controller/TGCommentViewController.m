//
//  TGCommentViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 10/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGCommentViewController.h"
#import "TGPostCell.h"
#import "TGPost.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "TGComment.h"
#import <MJExtension.h>
#import "TGCommentHeaderView.h"
#import "TGCommentCell.h"

//static NSInteger const TGHeaderLabelTag = 99;
static NSString * const TGCommentId = @"comment";

@interface TGCommentViewController () <UITableViewDelegate, UITableViewDataSource>

// Tool bar bottom margin
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomSpace;
// Table view
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// Top comments
@property (nonatomic, strong) NSArray *topComments;
// Latest comments
@property (nonatomic, strong) NSMutableArray *latestComments;
// Save loaded top comment
@property (nonatomic, strong) TGComment *saved_top_cmt;

// Save current page
@property (nonatomic, assign) NSInteger page;
// Manager
@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation TGCommentViewController

- (AFHTTPSessionManager *)manager {
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
    }
    
    return _manager;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set up basic layout
    [self setUpBasicLayout];
    
    // Set up header view
    [self setUpHeader];
    
    // Add refreshing widget
    [self setUpRefresh];
}

/**
 *  Set up refreshing
 */
- (void)setUpRefresh {
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComments)];
    
    // Begin refreshing
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreComments)];
    
    self.tableView.mj_footer.hidden = YES;
}


#pragma mark - Data processing

/**
 *  Load new comment data
 */
- (void)loadNewComments {
    // End previous request
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // Request parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.post.ID;
    params[@"hot"] = @"1";
    
    // Send request
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        // Return if there is no comment
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            // End refreshing
            [self.tableView.mj_header endRefreshing];
            
            return;
        }
        
        // Convert dictionary array to model array
        self.topComments = [TGComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        self.latestComments = [TGComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // Page
        self.page = 1;
        
        // Reload table
        [self.tableView reloadData];
        
        // End refreshing
        [self.tableView.mj_header endRefreshing];
        
        // Control footer refreshing view's status
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // No more new data
            self.tableView.mj_footer.hidden = YES;
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // End refreshing
        [self.tableView.mj_header endRefreshing];
    }];
#pragma clang diagnostic pop
}

/**
 *  Load more comment data
 */
- (void)loadMoreComments {
    // End previous request
    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
    // Page
    NSInteger page = self.page + 1;
    
    // Request parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.post.ID;
    params[@"page"] = @(page);
    TGComment *cmt = [self.latestComments lastObject];
    params[@"lastcid"] = cmt.ID;
    
    // Send request
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [self.manager GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        // Return if there is no comment
        if (![responseObject isKindOfClass:[NSDictionary class]]) {
            self.tableView.mj_footer.hidden = YES;
            
            return;
        }
        
        // Convert dictionary array to model array
        NSArray *newComments = [TGComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        [self.latestComments addObjectsFromArray:newComments];
        
        // Page
        self.page = page;
        
        // Reload table
        [self.tableView reloadData];
        
        // Control footer refreshing view's status
        NSInteger total = [responseObject[@"total"] integerValue];
        if (self.latestComments.count >= total) { // No more new data
            self.tableView.mj_footer.hidden = YES;
        } else {
            // End refreshing
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // End refreshing
        [self.tableView.mj_footer endRefreshing];
    }];
#pragma clang diagnostic pop
}

#pragma mark - View layout setup

/**
 *  Set up table view's header
 */
- (void)setUpHeader {
    // Create header
    UIView *header = [[UIView alloc] init];
    
    // Clear top_cmt
    if (self.post.top_cmt) {
        self.saved_top_cmt = self.post.top_cmt;
        self.post.top_cmt = nil;
        [self.post setValue:@0 forKey:@"cellHeight"]; // @"_cellHeight" is also OK
    }
    
    // Add cell
    TGPostCell *cell = [TGPostCell cell];
    cell.post = self.post;
    cell.size = CGSizeMake(TGScreenW, self.post.cellHeight);
    [header addSubview:cell];
    
    // Set header's height
    header.height = self.post.cellHeight + TGPostCellMargin;
    
    // Set header
    self.tableView.tableHeaderView = header;
}

/**
 *  Initialize basic layout
 */
- (void)setUpBasicLayout {
    // Set title
    self.title = @"Comments";
    
    // Add top-right button
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highlightedImage:@"comment_nav_item_share_icon_click" target:nil action:nil];
    
    // Add keyboard monitor
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // Set cell height
    self.tableView.estimatedRowHeight = 44;
    self.tableView.rowHeight = UITableViewAutomaticDimension; // Available from iOS 8
    
    // Set background color
    self.tableView.backgroundColor = TGGlobalBackgroundColor;
    
    // Register comment cell xib
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TGCommentCell class]) bundle:nil] forCellReuseIdentifier:TGCommentId];
    
    // Remove default cell separator
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // Set padding
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, TGPostCellMargin, 0);
}

/**
 *  Monitor keyboard
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    // Get the frame when keyboard hide/show ends
    CGRect frame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // Adjust tool bar bottom margin
    self.bottomSpace.constant = TGScreenH - frame.origin.y;
    
    // Get animation duration of keyboard hide/show
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Implement animation to relayout
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

/**
 *  Deallocate the memory occupied by the receiver
 */
- (void)dealloc {
    // Remove keyboard observer once view controller dies
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    // Resume post's top_cmt
    if (self.saved_top_cmt) {
        self.post.top_cmt = self.saved_top_cmt;
        [self.post setValue:@0 forKey:@"cellHeight"]; // Re-calculate cell height
    }
    
    // Cancel all networking requests
//    [self.manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    [self.manager invalidateSessionCancelingTasks:YES]; // Disable session
}

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger topCmtCount = self.topComments.count;
    NSInteger latestCmtCount = self.latestComments.count;
    
    if (topCmtCount) return 2; // Both top comments and latest comments exist, i.e., 2 sections
    if (latestCmtCount) return 1; // Only latest comments exist, i.e., 1 section
    
    return 0; // No comment yet
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger topCmtCount = self.topComments.count;
    NSInteger latestCmtCount = self.latestComments.count;
    
    // // Control footer refreshing view to show/hide
    tableView.mj_footer.hidden = (latestCmtCount == 0);
    
    if (section == 0) {
        return topCmtCount ? topCmtCount : latestCmtCount;
    }
    
    return latestCmtCount;
}

/*
// Set each section's title
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // Create header
    UIView *header = [[UIView alloc] init];
    header.backgroundColor = TGGlobalBackgroundColor;
    
    // Create label
    UILabel *label = [[UILabel alloc] init];
    label.textColor = TGRGBColor(67, 67, 67);
    label.width = 200;
    label.x = TGPostCellMargin;
    label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [header addSubview:label];
    
    // Set text
    NSInteger topCmtCount = self.topComments.count;
    
    if (section == 0) {
        label.text = topCmtCount ? @"Top Comments" : @"Latest Comments";
    } else { // Non-0 section, i.e., Section 1
        label.text = @"Latest Comments";
    }
    
    return header;
}

// Return header view's height, or section header will not display from iOS 8
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    header.height = UIViewAutoresizingFlexibleHeight;
    
    return header.height;
}
*/

/*
// Set each section's title
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *ID = @"header";
    
    // Acquire header from buffer pool
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    
    // Internal label widget
    UILabel *label = nil;
    
    if (header == nil) { // Not available in buffer pool, create new header
        header = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:ID];
        header.contentView.backgroundColor = TGGlobalBackgroundColor;
        
        // Create label
        label = [[UILabel alloc] init];
        label.textColor = TGRGBColor(67, 67, 67);
        label.width = 200;
        label.x = TGPostCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        label.tag = TGHeaderLabelTag;
        [header addSubview:label];
    } else { // Acquire header from buffer pool
        label = (UILabel *)[header viewWithTag:TGHeaderLabelTag];
    }
    
    // Set text
    NSInteger topCmtCount = self.topComments.count;
    
    if (section == 0) {
        label.text = topCmtCount ? @"Top Comments" : @"Latest Comments";
    } else { // Non-0 section, i.e., Section 1
        label.text = @"Latest Comments";
    }
    
    return header;
}
*/

/**
 *  Set each section's title
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // Acquire header from buffer pool
    TGCommentHeaderView *header = [TGCommentHeaderView headerViewWithTableView:tableView];
    
    // Set label text
    NSInteger topCmtCount = self.topComments.count;
    
    if (section == 0) {
        header.title = topCmtCount ? @"Top Comments" : @"Latest Comments";
    } else { // Non-0 section, i.e., Section 1
        header.title = @"Latest Comments";
    }
    
    return header;
}

/**
 *  Return header view's height, or section header will not display from iOS 8
 */
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] init];
    header.height = UIViewAutoresizingFlexibleHeight;
    
    return header.height;
}

/**
 *  Return table view's cell data
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TGCommentId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    
    TGComment *comment = [self commentInIndexPath:indexPath];
    cell.textLabel.text = comment.content;
    */
    
    TGCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:TGCommentId];
    
    cell.comment = [self commentInIndexPath:indexPath];
    
    return cell;
}

/**
 *  Return the comment array of one section
 */
- (NSArray *)commentsInSection:(NSInteger)section {
    if (section == 0) {
        return self.topComments.count ? self.topComments : self.latestComments;
    }
    
    return self.latestComments;
}

/**
 *  Return the comment of one row
 */
- (TGComment *)commentInIndexPath:(NSIndexPath *)indexPath {
    return [self commentsInSection:indexPath.section][indexPath.row];
}

#pragma mark - <UITableViewDelegate>

/**
 *  Perform actions when dragging scroll view
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    // Disable text field editing once dragging
    [self.view endEditing:YES];
    
    // Make shown menu controller invisible once dragging
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}

/**
 *  Perform actions when one table view cell is selected
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Create menu controller
    UIMenuController *menu = [UIMenuController sharedMenuController];
    
    if (menu.isMenuVisible) {
        // Set shown menu controller invisible
        [menu setMenuVisible:NO animated:YES];
    } else {
        // Acquire the selected cell
        TGCommentCell *cell = (TGCommentCell *)[tableView cellForRowAtIndexPath:indexPath];
        
        // Set the first responder
        [cell becomeFirstResponder];
        
        // Show menu controller
        UIMenuItem *like = [[UIMenuItem alloc] initWithTitle:@"Like" action:@selector(Like:)];
        UIMenuItem *reply = [[UIMenuItem alloc] initWithTitle:@"Reply" action:@selector(Reply:)];
        UIMenuItem *report = [[UIMenuItem alloc] initWithTitle:@"Report" action:@selector(Report:)];
        menu.menuItems = @[like, reply, report];
        CGRect rect = CGRectMake(0, cell.height * 0.5, cell.width, cell.height * 0.5);
        [menu setTargetRect:rect inView:cell];
        [menu setMenuVisible:YES animated:YES];
    }
}

#pragma mark - Menu items processing

- (void)Like:(UIMenuController *)menu {
    TGLog(@"%s %@", __func__, menu);
}

- (void)Reply:(UIMenuController *)menu {
    TGLog(@"%s %@", __func__, menu);
}

- (void)Report:(UIMenuController *)menu {
    TGLog(@"%s %@", __func__, menu);
}

@end
