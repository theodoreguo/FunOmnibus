//
//  TGRecommendUserCell.h
//  MyWeibo
//
//  Created by Theodore Guo on 27/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGRecommendUser;

@interface TGRecommendUserCell : UITableViewCell

// User model
@property (nonatomic, strong) TGRecommendUser *user;

@end
