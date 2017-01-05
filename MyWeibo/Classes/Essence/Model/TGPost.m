//
//  TGPost.m
//  MyWeibo
//
//  Created by Theodore Guo on 4/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGPost.h"

@implementation TGPost

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
            
            if (cmps.hour >= 1) {
                if (cmps.hour == 1) {
                    return [NSString stringWithFormat:@"%zd hr", cmps.hour];
                } else {
                    return [NSString stringWithFormat:@"%zd hrs", cmps.hour];
                }
            } else if (cmps.minute >= 1) {
                if (cmps.minute == 1) {
                    return [NSString stringWithFormat:@"%zd min", cmps.minute];
                } else {
                    return [NSString stringWithFormat:@"%zd mins", cmps.minute];
                }
            } else {
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

@end
