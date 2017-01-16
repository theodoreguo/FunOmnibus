//
//  TGMeCell.m
//  MyWeibo
//
//  Created by Theodore Guo on 12/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGMeCell.h"

@implementation TGMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        // Set background
        UIImageView *bgView = [[UIImageView alloc] init];
        bgView.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bgView;
        
        // Set text
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:16];
    }
 
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Return if the cell has no image
    if (self.imageView.image == nil) return;
    
    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + TGPostCellMargin;
}

/*
- (void)setFrame:(CGRect)frame {
    frame.origin.y -= (35 - TGPostCellMargin); // Move the frame 25 up
    
    [super setFrame:frame];
}
*/

@end
