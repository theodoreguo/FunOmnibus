//
//  TGRecommendCategory.m
//  MyWeibo
//
//  Created by Theodore Guo on 27/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGRecommendCategory.h"
#import <MJExtension.h>

@implementation TGRecommendCategory

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{@"ID" : @"id"};
}

/*
+ (id)mj_replacedKeyFromPropertyName121:(NSString *)propertyName {
    if ([propertyName isEqualToString:@"ID"]) return @"id";
    
    return propertyName;
}
*/

- (NSMutableArray *)users {
    if (!_users) {
        _users = [NSMutableArray array];
    }
    
    return _users;
}

@end
