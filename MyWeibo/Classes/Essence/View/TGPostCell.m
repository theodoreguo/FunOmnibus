//
//  TGPostCell.m
//  MyWeibo
//
//  Created by Theodore Guo on 5/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGPostCell.h"
#import "TGPost.h"
#import <UIImageView+WebCache.h>

@interface TGPostCell ()

// Profile
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
// Nickname
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
// Post time
@property (weak, nonatomic) IBOutlet UILabel *postTimeLabel;
// Like
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
// Unlike
@property (weak, nonatomic) IBOutlet UIButton *dislikeButton;
// Share
@property (weak, nonatomic) IBOutlet UIButton *repostButton;
// Comment
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
// Sina VIP
@property (weak, nonatomic) IBOutlet UIImageView *sinaVView;

@end

@implementation TGPostCell

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
}

- (void)setPost:(TGPost *)post {
    _post = post;

    // Judge to show Sina VIP logo
    self.sinaVView.hidden = !post.isSina_v;
    
    // Set profile
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:post.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    
    // Set nickname
    self.nameLabel.text = post.name;
    
    // Set post time with customised format
    self.postTimeLabel.text = post.create_time;
    
    // Set buttons' title
    [self setUpButtonTitle:self.likeButton count:post.ding placeholder:@"Like"];
    [self setUpButtonTitle:self.dislikeButton count:post.cai placeholder:@"Dislike"];
    [self setUpButtonTitle:self.repostButton count:post.repost placeholder:@"Repost"];
    [self setUpButtonTitle:self.commentButton count:post.comment placeholder:@"Comment"];
}

-(void)setUpButtonTitle:(UIButton *)button count:(NSInteger)count placeholder:(NSString *)placeholder {
    if (count > 1000) {
        placeholder = [NSString stringWithFormat:@"%.1fK", count / 1000.0];
    } else if (count > 0) {
        placeholder = [NSString stringWithFormat:@"%zd", count];
    }
    
    [button setTitle:placeholder forState:UIControlStateNormal];
}

- (void)setFrame:(CGRect)frame {
    static CGFloat margin = 10;
    
    frame.origin.x = margin;
    frame.size.width -= 2 * margin;
    frame.size.height -= margin;
    frame.origin.y += margin;
    
    [super setFrame:frame];
}

@end
