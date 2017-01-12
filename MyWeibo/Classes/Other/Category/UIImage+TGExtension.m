//
//  UIImage+TGExtension.m
//  MyWeibo
//
//  Created by Theodore Guo on 12/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "UIImage+TGExtension.h"

@implementation UIImage (TGExtension)

- (UIImage *)circleImage {
    // Creates a bitmap-based graphics context
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0); // 'NO' means transparent
    
    // Acquire context
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // Add a circle
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(ctx, rect);
    
    // Clip
    CGContextClip(ctx);
    
    // Draw
    [self drawInRect:rect];
    
    // Assign context to image
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    // End context
    UIGraphicsEndImageContext();
    
    return image;
}

@end
