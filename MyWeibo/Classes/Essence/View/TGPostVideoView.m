//
//  TGPostVideoView.m
//  MyWeibo
//
//  Created by Theodore Guo on 10/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGPostVideoView.h"
#import "TGPost.h"
#import <UIImageView+WebCache.h>
#import "TGShowPictureViewController.h"

@interface TGPostVideoView ()

// Image
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
// Play times
@property (weak, nonatomic) IBOutlet UILabel *playTimesLabel;
// Video duration
@property (weak, nonatomic) IBOutlet UILabel *videoDurationLabel;

@end

@implementation TGPostVideoView

+ (instancetype)videoView {
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
        self.playTimesLabel.text = [NSString stringWithFormat:@"%.1fK Views", post.playcount / 1000.0];
    } else if (post.playcount > 1) {
        self.playTimesLabel.text = [NSString stringWithFormat:@"%zd Views", post.playcount];
    } else if (post.playcount > 0) {
        self.playTimesLabel.text = [NSString stringWithFormat:@"%zd View", post.playcount];
    }
    
    // Audio duration
    NSInteger minute = post.videotime / 60;
    NSInteger second = post.videotime % 60;
    self.videoDurationLabel.text = [NSString stringWithFormat:@"%02zd:%02zd", minute, second];
}

@end
