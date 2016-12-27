//
//  TGRecommendCategoryCell.m
//  MyWeibo
//
//  Created by Theodore Guo on 27/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGRecommendCategoryCell.h"
#import "TGRecommendCategory.h"

@interface TGRecommendCategoryCell()

// Widget shown when selected
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation TGRecommendCategoryCell

- (void)awakeFromNib {
//    [super awakeFromNib];
    self.backgroundColor = TGRGBColor(244, 244, 244);
//    self.textLabel.textColor = TGRGBColor(78, 78, 78);
//    self.textLabel.highlightedTextColor = TGRGBColor(219, 21, 26);
    
//    UIView *bg = [[UIView alloc] init];
//    bg.backgroundColor = [UIColor clearColor];
//    self.selectedBackgroundView = bg;
}

- (void)setCategory:(TGRecommendCategory *)category {
    _category = category;
    
    self.textLabel.text = category.name;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Modify textLabel's frame to show the white customised table cell's  separators
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? TGRGBColor(219, 21, 26) : TGRGBColor(78, 78, 78);
}

@end
