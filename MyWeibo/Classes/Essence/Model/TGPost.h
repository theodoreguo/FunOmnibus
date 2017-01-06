//
//  TGPost.h
//  MyWeibo
//
//  Created by Theodore Guo on 4/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGPost : NSObject

// Name
@property (nonatomic, copy) NSString *name;
// Profile
@property (nonatomic, copy) NSString *profile_image;
// Post time
@property (nonatomic, copy) NSString *create_time;
// Content
@property (nonatomic, copy) NSString *text;
// Like quantity
@property (nonatomic, assign) NSInteger ding;
// Unlike quantity
@property (nonatomic, assign) NSInteger cai;
// Repost quantity
@property (nonatomic, assign) NSInteger repost;
// Comment quantity
@property (nonatomic, assign) NSInteger comment;
// Sina VIP
@property (nonatomic, assign, getter=isSina_v) BOOL sina_v;

@end
