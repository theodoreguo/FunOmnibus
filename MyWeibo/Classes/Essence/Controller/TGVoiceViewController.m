//
//  TGVoiceViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 2/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGVoiceViewController.h"

@interface TGVoiceViewController ()

@end

@implementation TGVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize table view
    [self setUpTableView];
}

-(void) setUpTableView {
    // Set padding
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = TGTitlesViewY + TGTitlesViewH;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    
    // Adjust scroll bar's padding
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor blueColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@----%zd", [self class], indexPath.row];
    
    return cell;
}

@end
