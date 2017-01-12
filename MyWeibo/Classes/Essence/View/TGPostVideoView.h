//
//  TGPostVideoView.h
//  MyWeibo
//
//  Created by Theodore Guo on 10/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//  Middle content of video post

#import <UIKit/UIKit.h>

@class TGPost;

@interface TGPostVideoView : UIView

+ (instancetype)videoView;

// Post data
@property (nonatomic, strong) TGPost *post;

@end
