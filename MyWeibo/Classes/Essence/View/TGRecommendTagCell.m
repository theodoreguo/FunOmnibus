//
//  TGRecommendTagCell.m
//  MyWeibo
//
//  Created by Theodore Guo on 30/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGRecommendTagCell.h"
#import "TGRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface TGRecommendTagCell()

@property (weak, nonatomic) IBOutlet UIImageView *imageListImageView;
@property (weak, nonatomic) IBOutlet UILabel *themeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subNumberLabel;

@end

@implementation TGRecommendTagCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setRecommendTag:(TGRecommendTag *)recommendTag {
    _recommendTag = recommendTag;
    
    [self.imageListImageView sd_setImageWithURL:[NSURL URLWithString:recommendTag.image_list] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.themeNameLabel.text = recommendTag.theme_name;
    
    NSString *subNumber = nil;
    if (recommendTag.sub_number < 10000) {
        subNumber = [NSString stringWithFormat:@"%zd SUBSCRIBERS", recommendTag.sub_number];
    } else { // > = 10K
        subNumber = [NSString stringWithFormat:@"%.1fK SUBSCRIBERS", recommendTag.sub_number / 1000.0];
    }
    self.subNumberLabel.text = subNumber;
}

- (void)setFrame:(CGRect)frame {
//    TGLog(@"setFrame --- %@",NSStringFromCGRect(frame));
    
    // Cell shifts 10 left
    frame.origin.x = 5;
    
    // Modify cell width to be symmetric shown in table view
    frame.size.width -= 2 * frame.origin.x;
    
    // Modify cell height to get separator effect
    frame.size.height -= 1;
    
    [super setFrame:frame];
}

@end
