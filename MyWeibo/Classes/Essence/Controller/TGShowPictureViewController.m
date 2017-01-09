//
//  TGShowPictureViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 7/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGShowPictureViewController.h"
#import "TGPost.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>
#import "TGProgressView.h"

@interface TGShowPictureViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;
@property (weak, nonatomic) IBOutlet TGProgressView *progressView;

@end

@implementation TGShowPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add image view
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(back)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // Picture size
    CGFloat pictureW = TGScreenW;
    CGFloat pictureH = pictureW * self.post.height / self.post.width;
    if (pictureH > TGScreenH) { // Picture exceeds screen height, scroll is needed to view full picture
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = TGScreenH * 0.5;
    }
    
    // Display current picture's download progress immediately
    [self.progressView setProgress:self.post.pictureProgress animated:YES];
    
    // Download picture
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.post.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        CGFloat progress = 1.0 * receivedSize / expectedSize;
        [self.progressView setProgress:progress animated:NO];
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.progressView.hidden = YES;
    }];
}

- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save {
    // Show reminder when picture download isn't completed
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"Download isn't completed"];
        return;
    }
    
    // Save picture to photo album
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"Save Failed"];
    } else {
        [SVProgressHUD showSuccessWithStatus:@"Save Succeeded"];
    }
}

@end
