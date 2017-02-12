//
//  TGPostPictureView.m
//  MyWeibo
//
//  Created by Theodore Guo on 6/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGPostPictureView.h"
#import "TGPost.h"
#import <UIImageView+WebCache.h>
#import "TGProgressView.h"
#import "TGShowPictureViewController.h"

@interface TGPostPictureView ()

// Image
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
// Gif indicator
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
// View full picture
@property (weak, nonatomic) IBOutlet UIButton *viewFullPicture;
// Progress view
@property (weak, nonatomic) IBOutlet TGProgressView *progressView;

@end

@implementation TGPostPictureView

+ (instancetype)pictureView {
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
    
    // Display latest download progress immediately (to avoid displaying other picture's download progress due to poor network)
    [self.progressView setProgress:post.pictureProgress animated:NO];
    
    // Set picture
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:post.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        self.progressView.hidden = NO;
        
        // Calculate progress
        post.pictureProgress = 1.0 * receivedSize / expectedSize;
        
        // Display progress
        [self.progressView setProgress:post.pictureProgress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
        
        // Realize displaying top part without scaling when picture hits height limit
        if (!post.isTooHighPicture) { // Process only it exceeds stipulated height
            return;
        }
        
        // Begin image context
        UIGraphicsBeginImageContextWithOptions(post.pictureViewFrame.size, YES, 0.0);
        
        // Draw downloaded picture in image context
        CGFloat width = post.pictureViewFrame.size.width;
        CGFloat height = width * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, width, height)];
        
        // Get picture
        self.imageView.image = UIGraphicsGetImageFromCurrentImageContext();
        
        // End image context
        UIGraphicsEndImageContext();
    }];

    // Judge to show gif indicator
    NSString *extension = post.large_image.pathExtension;
    self.gifView.hidden = ![extension.lowercaseString isEqualToString:@"gif"];
    
    // Judge to shwo "Click to view full picture"
    if (post.isTooHighPicture) { // Picture hits height limit
        self.viewFullPicture.hidden = NO;
//        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    } else { // Picture doesn't hit height limit
        self.viewFullPicture.hidden = YES;
//        self.imageView.contentMode = UIViewContentModeScaleToFill;
    }
}

@end
