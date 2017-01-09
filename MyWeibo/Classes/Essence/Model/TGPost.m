//
//  TGPost.m
//  MyWeibo
//
//  Created by Theodore Guo on 4/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGPost.h"
//#import <MJExtension.h>

@interface TGPost ()

{
    CGFloat _cellHeight;
    CGRect _pictureViewFrame;
} // It's needed when set "readonly" since no setter method will be automatically generated

@end

@implementation TGPost

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"small_image" : @"image0",
             @"middle_image" : @"image2",
             @"large_image" : @"image1"
             };
}

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
        } else { // Others
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
        _cellHeight = TGPostCellTextY + textH + 2 * TGPostCellMargin; // Not sure why it's 2 * instead of 1 *
        
        // Calculate cell height based on post type
        if (self.type == TGPostTypePicture) { // Picture post
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
            CGFloat pictureY = TGPostCellTextY + textH + 2 * TGPostCellMargin;
            _pictureViewFrame = CGRectMake(pictureX, pictureY, pictureW, pictureH);
            
            _cellHeight += pictureH + TGPostCellMargin;
        } else if (self.type == TGPostTypeVoice) { // Voice post
            
        }

        
        // Bottom tool bar height
        _cellHeight += TGPostCellBottomBarH + TGPostCellMargin;
    }
    
    return _cellHeight;
}

@end
