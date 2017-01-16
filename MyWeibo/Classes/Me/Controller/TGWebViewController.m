//
//  TGWebViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 13/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGWebViewController.h"

@interface TGWebViewController () <UIWebViewDelegate>

// Web view
@property (weak, nonatomic) IBOutlet UIWebView *webView;
// Back item
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backItem;
// Forward item
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardItem;

@end

@implementation TGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set delegate
    self.webView.delegate = self;
    
    // Load URL request
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (IBAction)refresh:(id)sender {
    [self.webView reload];
}

- (IBAction)back:(id)sender {
    [self.webView goBack];
}

- (IBAction)forward:(id)sender {
    [self.webView goForward];
}

#pragma mark - <UIWebViewDelegate>

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.backItem.enabled = webView.canGoBack;
    self.forwardItem.enabled = webView.canGoForward;
}

@end
