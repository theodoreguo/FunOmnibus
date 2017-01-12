//
//  TGPostAudioView.h
//  MyWeibo
//
//  Created by Theodore Guo on 10/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//  Middle content of audio post

#import <UIKit/UIKit.h>

@class TGPost;

@interface TGPostAudioView : UIView

+ (instancetype)audioView;

// Post data
@property (nonatomic, strong) TGPost *post;

@end
