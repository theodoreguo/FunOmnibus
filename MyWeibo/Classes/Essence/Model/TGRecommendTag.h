//
//  TGRecommendTag.h
//  MyWeibo
//
//  Created by Theodore Guo on 30/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGRecommendTag : NSObject

// Image
@property (nonatomic, copy) NSString *image_list;
// Name
@property (nonatomic, copy) NSString *theme_name;
// Subscription count
@property (nonatomic, assign) NSInteger sub_number;

@end
