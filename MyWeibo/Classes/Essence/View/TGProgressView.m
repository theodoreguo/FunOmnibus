//
//  TGProgressView.m
//  MyWeibo
//
//  Created by Theodore Guo on 7/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGProgressView.h"

@implementation TGProgressView

- (void)awakeFromNib {
    // Set progress view properties
    self.roundedCorners = 2; // Set progress bar as rounded corner
    self.progressLabel.textColor = [UIColor whiteColor];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    [super setProgress:progress animated:animated];
    
    // Resolve -0% bug
    NSString *text = [NSString stringWithFormat:@"%.0f%%", progress * 100];
    self.progressLabel.text = [text stringByReplacingOccurrencesOfString:@"-" withString:@""];
}

@end
