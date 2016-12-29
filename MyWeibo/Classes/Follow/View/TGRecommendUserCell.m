//
//  TGRecommendUserCell.m
//  MyWeibo
//
//  Created by Theodore Guo on 27/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGRecommendUserCell.h"
#import "TGRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface TGRecommendUserCell()

@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nicknameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fanQuantityLabel;

@end

@implementation TGRecommendUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setUser:(TGRecommendUser *)user {
    _user = user;
    
    self.nicknameLabel.text = user.screen_name;
    self.fanQuantityLabel.text = [NSString stringWithFormat:@"%zd FOLLOWERS", user.fans_count];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:user.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
}

@end
