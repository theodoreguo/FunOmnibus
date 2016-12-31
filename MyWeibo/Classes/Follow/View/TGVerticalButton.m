//
//  TGVerticalButton.m
//  MyWeibo
//
//  Created by Theodore Guo on 31/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGVerticalButton.h"

@implementation TGVerticalButton

// Set text alignment
- (void)setUp {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

// Make sure layout setup work no matter it is set up via code or xib/storyboard
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUp];
    }
    
    return self;
}

- (void)awakeFromNib {
    [self setUp];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Adjust image layout
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.imageView.width;
    
    // Adjust text layout
    self.titleLabel.x = 0;
    self.titleLabel.y = self.imageView.height;
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

@end
