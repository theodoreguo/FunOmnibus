//
//  TGPostPictureView.h
//  MyWeibo
//
//  Created by Theodore Guo on 6/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//  Middle content of picture post

#import <UIKit/UIKit.h>

@class TGPost;

@interface TGPostPictureView : UIView

+ (instancetype)pictureView;

// Post data
@property (nonatomic, strong) TGPost *post;

@end
