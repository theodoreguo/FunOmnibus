//
//  TGRecommendCategoryCell.h
//  MyWeibo
//
//  Created by Theodore Guo on 27/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGRecommendCategory;

@interface TGRecommendCategoryCell : UITableViewCell

// Category model
@property (nonatomic, strong) TGRecommendCategory *category;

@end
