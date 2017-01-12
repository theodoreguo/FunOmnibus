//
//  TGComment.h
//  MyWeibo
//
//  Created by Theodore Guo on 10/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TGUser;

@interface TGComment : NSObject

// ID
@property (nonatomic, copy) NSString *ID;
// Audio comment duration
@property (nonatomic, assign) NSInteger voicetime;
// Audio comment's URL
@property (nonatomic, copy) NSString *voiceurl;
// Comment content
@property (nonatomic, copy) NSString *content;
// Comment's like quantity
@property (nonatomic, assign) NSInteger like_count;
// User
@property (nonatomic, strong) TGUser *user;

@end
