//
//  TGEssenceViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 23/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGEssenceViewController.h"
#import "TGRecommendTagViewController.h"
#import "TGPostViewController.h"

@interface TGEssenceViewController () <UIScrollViewDelegate>

// Red indicator of tab bar bottom
@property (nonatomic, weak) UIView *indicatorView;
// Button selected
@property (nonatomic, weak) UIButton *selectedButton;
// Top tab bar
@property (nonatomic, weak) UIView *titlesView;
// Bottom content
@property (nonatomic, weak) UIScrollView *contentView;

@end

@implementation TGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up navigation bar
    [self setUpNavi];
    
    // Initialize child view controller
    [self setUpChildVc];
    
    // Set up top title tab bar
    [self setUpTitlesView];
    
    // Set up bottom scroll view
    [self setUpContentView];
}

/**
 *  Set up navigation bar content
 */
-(void)setUpNavi {
    // Set navigation bar title
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // Set navigation bar left button
    /*
     UIButton *tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
     [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIcon"] forState:UIControlStateNormal];
     [tagButton setBackgroundImage:[UIImage imageNamed:@"MainTagSubIconClick"] forState:UIControlStateHighlighted];
     tagButton.size = tagButton.currentBackgroundImage.size;
     [tagButton addTarget:self action:@selector(tagClick) forControlEvents:UIControlEventTouchUpInside];
     self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tagButton];
     */
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highlightedImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    
    // Set background color
    self.view.backgroundColor = TGGlobalBackgroundColor;

}

/**
 *  Set up top title tab bar
 */
- (void)setUpTitlesView {
    // Overall setup
    UIView *titlesView = [[UIView alloc] init];
//    titlesView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
//    titlesView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.5];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = TGTitlesViewH;
    titlesView.y = TGTitlesViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // Red indicator of tab bar bottom
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // Internal child tabs
//    NSArray *titles = @[@"All", @"Video", @"Voice", @"Picture", @"Joke" ];
//    CGFloat width = titlesView.width / titles.count;
    CGFloat width = titlesView.width / self.childViewControllers.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.height = height;
        button.width = width;
        button.x = i * width;
//        [button setTitle:titles[i] forState:UIControlStateNormal];
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
//        [button layoutIfNeeded]; // Lay out the subviews immediately to update child controls' frame compulsorily
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        // Set first title selected by default
        if (i == 0) {
            button.enabled = NO;
            self.selectedButton = button;
            
            // Make button's lable to calculate size based on text content
            [button.titleLabel sizeToFit];
            
            
            self.indicatorView.width = button.titleLabel.width;
            //            // Another method to show indicator by defualt
            //            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName: button.titleLabel.font}].width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}

/**
 *  Click title tab bar
 *
 *  @param button title tab button
 */
- (void)titleClick:(UIButton *)button {
    // Modify button's status to set selected button's color
    self.selectedButton.enabled = YES;
    button.enabled = NO;
    self.selectedButton = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        // Set indicator's width equal to text's
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // Scroll
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}

/**
 *  Set up bottom scroll view
 */
- (void)setUpContentView {
    // Disable inset auto adjustment
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
//    contentView.backgroundColor = [UIColor blueColor];
    contentView.frame = self.view.bounds;
    
    // Set padding
    /*
//    CGFloat bottom = self.tabBarController.tabBar.height;
//    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
//    contentView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    */
    contentView.delegate = self;
    contentView.pagingEnabled = YES; // Enable scroll view pagging
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    /*
//    [contentView addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
//    UISwitch *s = [[UISwitch alloc] init];
//    s.y = 800 - s.height;
//    [contentView addSubview:s];
//    [self.view addSubview:contentView];
//
//    contentView.contentSize = CGSizeMake(0, 800);
    //    contentView.width = self.view.width;
    //    contentView.y = 99;
    //    contentView.height = self.view.height - contentView.y - self.tabBarController.tabBar.height;
    */
    
    // Add the first controller's view (i.e., All)
    [self scrollViewDidEndScrollingAnimation:contentView];
}

// Initialize child view controller
- (void)setUpChildVc {
    TGPostViewController *all = [[TGPostViewController alloc] init];
    all.title = @"All";
    all.type = TGPostTypeAll;
    [self addChildViewController:all];
    
    TGPostViewController *video = [[TGPostViewController alloc] init];
    video.title = @"Video";
    video.type = TGPostTypeVideo;
    [self addChildViewController:video];
    
    TGPostViewController *audio = [[TGPostViewController alloc] init];
    audio.title = @"Audio";
    audio.type = TGPostTypeAudio;
    [self addChildViewController:audio];
    
    TGPostViewController *picture = [[TGPostViewController alloc] init];
    picture.title = @"Picture";
    picture.type = TGPostTypePicture;
    [self addChildViewController:picture];
    
    TGPostViewController *joke = [[TGPostViewController alloc] init];
    joke.title = @"Joke";
    joke.type = TGPostTypeJoke;
    [self addChildViewController:joke];
}

- (void)tagClick {
    TGRecommendTagViewController *tag = [[TGRecommendTagViewController alloc] init];
    [self.navigationController pushViewController:tag animated:YES];
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    TGTestViewController *vc = [[TGTestViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
*/

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // Add child view controllers' view
    
    // Current index
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // Acquire child view controllers
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0; // Set controller view's y equal to 0 instead of 20 by default
    vc.view.height = scrollView.height; // Set controller view's height equal to 667 (screen height) instead of 647 by default
    
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // Click button
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}

@end
