//
//  TGRecommendUser.h
//  MyWeibo
//
//  Created by Theodore Guo on 28/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGRecommendUser : NSObject

// Profile
@property (nonatomic, copy) NSString *header;
// Fans' quantity
@property (nonatomic, assign) NSInteger fans_count;
// Nickname
@property (nonatomic, copy) NSString *screen_name;

@end
