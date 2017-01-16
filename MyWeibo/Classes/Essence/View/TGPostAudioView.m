//
//  TGPostAudioView.m
//  MyWeibo
//
//  Created by Theodore Guo on 10/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGPostAudioView.h"
#import "TGPost.h"
#import <UIImageView+WebCache.h>
#import "TGShowPictureViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface TGPostAudioView ()

// Image
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
// Play times
@property (weak, nonatomic) IBOutlet UILabel *playTimesLabel;
// Audio duration
@property (weak, nonatomic) IBOutlet UILabel *audioDurationLabel;
// Play button
@property (weak, nonatomic) IBOutlet UIButton *playButton;
// Player view controller
@property (nonatomic, strong) MPMoviePlayerViewController *playerVc;

@end

@implementation TGPostAudioView

- (MPMoviePlayerViewController *)playerVc {
    if (!_playerVc) {
        NSURL *url = [NSURL URLWithString:self.post.voiceuri];
        _playerVc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    }
    
    return _playerVc;
}

+ (instancetype)audioView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib {
    // Disable picture view to stretch with cell size's change
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // Add monitor to picture
    self.imageView.userInteractionEnabled = YES;
    [self.imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget: self action:@selector(showPicture)]];
}

- (void)showPicture {
    TGShowPictureViewController *showPicture = [[TGShowPictureViewController alloc] init];
    showPicture.post = self.post;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:showPicture animated:YES completion:nil];
}

- (void)setPost:(TGPost *)post {
    _post = post;
    
    // Picture
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:post.large_image]];
    
    // Play times
    if (post.playcount > 1000) {
        self.playTimesLabel.text = [NSString stringWithFormat:@"%.1fK Plays", post.playcount / 1000.0];
    } else if (post.playcount > 1) {
        self.playTimesLabel.text = [NSString stringWithFormat:@"%zd Plays", post.playcount];
    } else if (post.playcount > 0) {
        self.playTimesLabel.text = [NSString stringWithFormat:@"%zd Play", post.playcount];
    }
    
    // Audio duration
    NSInteger minute = post.voicetime / 60;
    NSInteger second = post.voicetime % 60;
    self.audioDurationLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
    
    // Moniter play button
    [self.playButton addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
}
// Play audio
- (IBAction)playAudio {
    [[UIApplication sharedApplication].keyWindow.rootViewController presentMoviePlayerViewControllerAnimated:self.playerVc];
}

@end
