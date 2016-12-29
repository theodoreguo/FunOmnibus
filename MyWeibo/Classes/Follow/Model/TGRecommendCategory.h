//
//  TGRecommendCategory.h
//  MyWeibo
//
//  Created by Theodore Guo on 27/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

// Data model of left recommendation category part
#import <Foundation/Foundation.h>

@interface TGRecommendCategory : NSObject

// id
@property (nonatomic, assign) NSInteger id;
// count
@property (nonatomic, assign) NSInteger count;
// name
@property (nonatomic, copy) NSString *name;

// User data corresponding to this category
@property (nonatomic, strong) NSMutableArray *users;

@end
