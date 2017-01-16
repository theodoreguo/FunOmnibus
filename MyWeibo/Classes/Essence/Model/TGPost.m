//
//  TGPost.m
//  MyWeibo
//
//  Created by Theodore Guo on 4/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGPost.h"
#import <MJExtension.h>
//#import "TGComment.h"
#import "TGComment.h"
#import "TGUser.h"

@interface TGPost ()

{
    CGFloat _cellHeight;
} // It's needed when property is set as "readonly" and the auto generated getter method is overridden (no setter method will be automatically generated)

@end

@implementation TGPost

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"small_image" : @"image0",
             @"middle_image" : @"image2",
             @"large_image" : @"image1",
             @"ID" : @"id",
             @"top_cmt" : @"top_cmt[0]"
             };
}

//// Convert NSArray to TGComment via mj_objectClassInArray
//+ (NSDictionary *)mj_objectClassInArray {
////    return @{@"top_cmt" : [TGComment class]};
//    return @{@"top_cmt" : @"TGComment"};
//}

- (NSString *)create_time {
    // Date formatter class
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    // Set date format
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    // Post time
    NSDate *postTime = [fmt dateFromString:_create_time];
    
    if (postTime.isThisYear) { // This year
        if (postTime.isToday) { // Today
            NSDateComponents *cmps = [[NSDate date] deltaFrom:postTime];
            
            if (cmps.hour >= 1) { // Delta >= 1 hr
                if (cmps.hour == 1) {
                    return [NSString stringWithFormat:@"%zd hr", cmps.hour];
                } else {
                    return [NSString stringWithFormat:@"%zd hrs", cmps.hour];
                }
            } else if (cmps.minute >= 1) { // 1 hr > Delta >= 1 min
                if (cmps.minute == 1) {
                    return [NSString stringWithFormat:@"%zd min", cmps.minute];
                } else {
                    return [NSString stringWithFormat:@"%zd mins", cmps.minute];
                }
            } else { // 1 min > Delta
                return @"Just now";
            }
        } else if (postTime.isYesterday) { // Yesterday
            fmt.dateFormat = @"'Yesterday' HH:mm:ss";
            return [fmt stringFromDate:postTime];
        } else { // Other
            fmt.dateFormat = @"MM-dd HH:mm:ss";
            return [fmt stringFromDate:postTime];
        }
    } else { // Not this year
        return _create_time;
    }
}

- (CGFloat)cellHeight {
    if (!_cellHeight) {
        // Content text's max size
        CGSize maxSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 4 * TGPostCellMargin, MAXFLOAT); // Constrain text width
        //    CGFloat textH = [post.text sizeWithFont:[UIFont systemFontOfSize:14] constrainedToSize:maxSize].height;
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // Cell height
        // Text height
        _cellHeight = TGPostCellTextY + textH + TGPostCellMargin;
        
        // Calculate cell height based on post type
        if (self.type == TGPostTypePicture) { // Picture post
            if (self.width != 0 && self.height != 0) {
                // Picture's displayed width
                CGFloat pictureW = maxSize.width;
                // Picture's displayed height
                CGFloat pictureH = pictureW * self.height / self.width;
                if (pictureH >= TGPostCellPictureMaxH) { // Picture exceeds stipulated limit
                    pictureH = TGPostCellPictureMaxDisplayH;
                    self.tooHighPicture = YES; // Hit max height limit
                }
                
                // Calculate picture view's frame
                CGFloat pictureX = TGPostCellMargin;
                CGFloat pictureY = TGPostCellTextY + textH + TGPostCellMargin;
                _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
                
                _cellHeight += pictureH + TGPostCellMargin;
            }
        } else if (self.type == TGPostTypeAudio) { // Audio post
            CGFloat audioX = TGPostCellMargin;
            CGFloat audioY = TGPostCellTextY + textH + TGPostCellMargin;
            CGFloat audioW = maxSize.width;
            CGFloat audioH = audioW * self.height / self.width;
            _audioViewFrame = CGRectMake(audioX, audioY, audioW, audioH);
            
            _cellHeight += audioH + TGPostCellMargin;
        } else if (self.type == TGPostTypeVideo) { // Video post
            CGFloat videoX = TGPostCellMargin;
            CGFloat videoY = TGPostCellTextY + textH + TGPostCellMargin;
            CGFloat videoW = maxSize.width;
            CGFloat videoH = videoW * self.height / self.width;
            _videoViewFrame = CGRectMake(videoX, videoY, videoW, videoH);
            
            _cellHeight += videoH + TGPostCellMargin;
        }
        
        // Top comment view height
        if (self.top_cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@", self.top_cmt.user.username, self.top_cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += TGPostCellTopCmtTitleH + contentH + TGPostCellMargin;
        }
        
        // Bottom tool bar height
        _cellHeight += TGPostCellBottomBarH + TGPostCellMargin;
    }
    
    return _cellHeight;
}

@end
