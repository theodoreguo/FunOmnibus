//
//  TGRecommendCategory.m
//  MyWeibo
//
//  Created by Theodore Guo on 27/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGRecommendCategory.h"

@implementation TGRecommendCategory

- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}

@end