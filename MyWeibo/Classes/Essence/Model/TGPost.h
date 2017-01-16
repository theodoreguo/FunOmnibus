//
//  TGPost.h
//  MyWeibo
//
//  Created by Theodore Guo on 4/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TGComment;

@interface TGPost : NSObject

// ID
@property (nonatomic, copy) NSString *ID;
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
// Picture width
@property (nonatomic, assign) CGFloat width;
// Picture height
@property (nonatomic, assign) CGFloat height;
// Picture's URL - Small
@property (nonatomic, copy) NSString *small_image;
// Picture's URL - Middle
@property (nonatomic, copy) NSString *middle_image;
// Picture's URL - Larege
@property (nonatomic, copy) NSString *large_image;
// Post type
@property (nonatomic, assign) TGPostType type;
// Audio duration
@property (nonatomic, assign) NSInteger voicetime;
// Video duration
@property (nonatomic, assign) NSInteger videotime;
// Audio play times
@property (nonatomic, assign) NSInteger playcount;
// Video's URL
@property (nonatomic, copy) NSString *videouri;
// Audio's URL
@property (nonatomic, copy) NSString *voiceuri;
// Top comment
@property (nonatomic, strong) TGComment *top_cmt;

// Extra assistive properties
// Cell height
@property (nonatomic, assign, readonly) CGFloat cellHeight;
// Picture view's frame
@property (nonatomic, assign, readonly) CGRect pictureViewFrame;
// Picture is too high or not
@property (nonatomic, assign, getter=isTooHighPicture) BOOL tooHighPicture;
// Picture download progress
@property (nonatomic, assign) CGFloat pictureProgress;
// Audio view's frame
@property (nonatomic, assign, readonly) CGRect audioViewFrame;
// Video view's frame
@property (nonatomic, assign, readonly) CGRect videoViewFrame;

@end
