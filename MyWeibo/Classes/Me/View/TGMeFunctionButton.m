//
//  TGMeFunctionButton.m
//  MyWeibo
//
//  Created by Theodore Guo on 13/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGMeFunctionButton.h"
#import "TGMefunctions.h"
#import <UIButton+WebCache.h>

@implementation TGMeFunctionButton

// Set text alignment and features
- (void)setUp {
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    [self setBackgroundImage:[UIImage imageNamed:@"mainCellBackground"] forState:UIControlStateNormal];
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
    self.imageView.y = self.height * 0.15;
    self.imageView.width = self.width * 0.5;
    self.imageView.height = self.imageView.width;
    self.imageView.centerX = self.width * 0.5;
    
    // Adjust text layout
    self.titleLabel.x = 0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame);
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.titleLabel.y;
}

- (void)setFunction:(TGMeFunctions *)function {
    _function = function;
    
    [self setTitle:function.name forState:UIControlStateNormal];
    // Set button's image using SDWebImage
    [self sd_setImageWithURL:[NSURL URLWithString:function.icon] forState:UIControlStateNormal];
}

@end
