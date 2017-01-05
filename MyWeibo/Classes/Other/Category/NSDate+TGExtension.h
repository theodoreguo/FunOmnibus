//
//  NSDate+TGExtension.h
//  MyWeibo
//
//  Created by Theodore Guo on 5/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (TGExtension)

// Compare the time interval between from and self
- (NSDateComponents *)deltaFrom:(NSDate *)from;

// Judge the post time is this year
- (BOOL)isThisYear;

// Judge the post time is today
- (BOOL)isToday;

// Judge the post time is yesterday
- (BOOL)isYesterday;

@end
