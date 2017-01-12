//
//  TGUser.h
//  MyWeibo
//
//  Created by Theodore Guo on 10/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TGUser : NSObject

// Username
@property (nonatomic, copy) NSString *username;
// Sex
@property (nonatomic, copy) NSString *sex;
// Profile
@property (nonatomic, copy) NSString *profile_image;

@end
