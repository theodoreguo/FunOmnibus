//
//  TGCommentHeaderView.h
//  MyWeibo
//
//  Created by Theodore Guo on 11/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TGCommentHeaderView : UITableViewHeaderFooterView

// Title data
@property (nonatomic, copy) NSString *title;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
