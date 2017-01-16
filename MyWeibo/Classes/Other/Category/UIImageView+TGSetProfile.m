//
//  UIImageView+TGSetProfile.m
//  MyWeibo
//
//  Created by Theodore Guo on 12/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "UIImageView+TGSetProfile.h"
#import "UIImageView+Webcache.h"

@implementation UIImageView (TGSetProfile)

- (void)setProfile:(NSString *)URL {
    UIImage *placeholder = [[UIImage imageNamed:@"defaultUserIcon"] circleImage];
    [self sd_setImageWithURL:[NSURL URLWithString:URL] placeholderImage:placeholder completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            self.image = image ? [image circleImage] : placeholder;
        }
    }];
}

@end
