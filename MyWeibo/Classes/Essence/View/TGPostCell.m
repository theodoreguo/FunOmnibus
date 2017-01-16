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
#import "TGPostPictureView.h"
#import "TGPostAudioView.h"
#import "TGPostVideoView.h"
#import "TGComment.h"
#import "TGUser.h"

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
// Text content
@property (weak, nonatomic) IBOutlet UILabel *contentTextLabel;
// Middle content of picture post
@property (nonatomic, weak) TGPostPictureView *pictureView;
// Middle content of audio post
@property (nonatomic, weak) TGPostAudioView *audioView;
// Middle content of video post
@property (nonatomic, weak) TGPostVideoView *videoView;
// Top comment content
@property (weak, nonatomic) IBOutlet UILabel *topCmtContentLabel;
// Top comment view
@property (weak, nonatomic) IBOutlet UIView *topCmtView;

@end

@implementation TGPostCell

+ (instancetype)cell {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] firstObject];
}

- (TGPostPictureView *)pictureView {
    if (!_pictureView) {
        TGPostPictureView *pictureView = [TGPostPictureView pictureView];
        [self.contentView addSubview:pictureView];
        _pictureView = pictureView;
    }
    
    return _pictureView;
}

- (TGPostAudioView *)audioView {
    if (!_audioView) {
        TGPostAudioView *audioView = [TGPostAudioView audioView];
        [self.contentView addSubview:audioView];
        _audioView = audioView;
    }
    
    return _audioView;
}

- (TGPostVideoView *)videoView {
    if (!_videoView) {
        TGPostVideoView *videoView = [TGPostVideoView videoView];
        [self.contentView addSubview:videoView];
        _videoView = videoView;
    }
    
    return _videoView;
}

- (void)awakeFromNib {
    UIImageView *bgView = [[UIImageView alloc] init];
    bgView.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bgView;
    
//    // Set circle profile
//    self.profileImageView.layer.cornerRadius = self.profileImageView.width * 0.5;
//    self.profileImageView.layer.masksToBounds = YES;
}

- (void)setPost:(TGPost *)post {
    _post = post;

    // Judge to show Sina VIP logo
    self.sinaVView.hidden = !post.isSina_v;
    
    // Set profile
    [self.profileImageView setProfile:post.profile_image];
    
    // Set nickname
    self.nameLabel.text = post.name;
    
    // Set post time with customised format
    self.postTimeLabel.text = post.create_time;
    
    // Set buttons' title
    [self setUpButtonTitle:self.likeButton count:post.ding placeholder:@"Like"];
    [self setUpButtonTitle:self.dislikeButton count:post.cai placeholder:@"Dislike"];
    [self setUpButtonTitle:self.repostButton count:post.repost placeholder:@"Repost"];
    [self setUpButtonTitle:self.commentButton count:post.comment placeholder:@"Comment"];
    
    // Set content text
    self.contentTextLabel.text = post.text;
    
    // Add corresponding content to cell middle part based on post type
    if (post.type == TGPostTypePicture) { // Picture post
        self.pictureView.hidden = NO;
        
        self.pictureView.post = post;
        self.pictureView.frame = post.pictureViewFrame;
        
        self.audioView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (post.type == TGPostTypeAudio) { // Audio post
        self.audioView.hidden = NO;
        
        self.audioView.post = post;
        self.audioView.frame = post.audioViewFrame;
        
        self.pictureView.hidden = YES;
        self.videoView.hidden = YES;
    } else if (post.type == TGPostTypeVideo) { // Video post
        self.videoView.hidden = NO;
        
        self.videoView.post = post;
        self.videoView.frame = post.videoViewFrame;
        
        self.pictureView.hidden = YES;
        self.audioView.hidden = YES;
    } else { // Joke post
        self.pictureView.hidden = YES; // To solve cell reusable issue
        self.audioView.hidden = YES;
        self.videoView.hidden = YES;
    }
    
    // Process top comment
    if (self.post.top_cmt) {
        self.topCmtView.hidden = NO; // To solve cell reusable issue
        self.topCmtContentLabel.text = [NSString stringWithFormat:@"%@ : %@", self.post.top_cmt.user.username, self.post.top_cmt.content];
    } else {
        self.topCmtView.hidden = YES;
    }
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
    frame.origin.x = TGPostCellMargin;
    frame.size.width -= 2 * TGPostCellMargin;
//    frame.size.height -= TGPostCellMargin; // Set the margin between cells
    frame.size.height = self.post.cellHeight - TGPostCellMargin;
    frame.origin.y += TGPostCellMargin; // Set the first cell has margin to top title bar
    
    [super setFrame:frame];
}

/**
 *  More button
 */
- (IBAction)more {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Favorite" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Report" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {}]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {}]];
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
}

@end
