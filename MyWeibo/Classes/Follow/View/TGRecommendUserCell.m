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
    
    NSString *fansCount = nil;
    if (user.fans_count < 10000) {
        fansCount = [NSString stringWithFormat:@"%zd FOLLOWERS", user.fans_count];
    } else { // > = 10K
        fansCount = [NSString stringWithFormat:@"%.1fK FOLLOWERS", user.fans_count / 1000.0];
    }
    self.fanQuantityLabel.text = fansCount;
    
    [self.profileImageView setProfile:user.header];

}

@end
