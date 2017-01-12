//
//  TGCommentCell.m
//  MyWeibo
//
//  Created by Theodore Guo on 11/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGCommentCell.h"
#import "TGComment.h"
#import <UIImageView+WebCache.h>
#import "TGUser.h"

@interface TGCommentCell ()

// Profile
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
// Sex
@property (weak, nonatomic) IBOutlet UIImageView *sexView;
// Username
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
// Comment content
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
// Like quantity
@property (weak, nonatomic) IBOutlet UILabel *likeCountLabel;
// Audio comment
@property (weak, nonatomic) IBOutlet UIButton *audioButton;

@end

@implementation TGCommentCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setComment:(TGComment *)comment {
    _comment = comment;
    
    // Acquire profile
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:comment.user.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // Acquire sex info
    self.sexView.image = [comment.user.sex isEqualToString:TGUserSexMale] ? [UIImage imageNamed:@"Profile_manIcon"] : [UIImage imageNamed:@"Profile_womanIcon"];
    
    // Acquire comment content
    self.contentLabel.text = comment.content;
    
    // Acquire username
    self.usernameLabel.text = comment.user.username;
    
    // Judge and show like count
    if (comment.like_count > 1000) {
        self.likeCountLabel.text = [NSString stringWithFormat:@"%.1fK", comment.like_count / 1000.0];
    } else if (comment.like_count > 0) {
        self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", comment.like_count];
    } else {
        self.likeCountLabel.text = [NSString stringWithFormat:@"%zd", 0];
    }
    
    // Process audio comment
    if (comment.voiceurl.length) { // Comment is audio
        self.audioButton.hidden = NO;
        [self.audioButton setTitle:[NSString stringWithFormat:@"%zd''", comment.voicetime] forState:UIControlStateNormal];
    } else {
        self.audioButton.hidden = YES;
    }
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x = TGPostCellMargin;
    frame.size.width -= 2 * TGPostCellMargin;
    
    [super setFrame:frame];
}

@end
