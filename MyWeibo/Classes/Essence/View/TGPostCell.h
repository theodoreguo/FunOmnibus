//
//  TGPostCell.h
//  MyWeibo
//
//  Created by Theodore Guo on 5/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGPost;

@interface TGPostCell : UITableViewCell

// Post data
@property (nonatomic, strong) TGPost *post;

+ (instancetype)cell;

@end
