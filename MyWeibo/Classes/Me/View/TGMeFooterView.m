//
//  TGMeFooterView.m
//  MyWeibo
//
//  Created by Theodore Guo on 12/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//

#import "TGMeFooterView.h"
#import <AFNetworking.h>
#import "TGMeFunctions.h"
#import <MJExtension.h>
#import "TGMeFunctionButton.h"
#import <SVProgressHUD.h>
#import "TGWebViewController.h"

@implementation TGMeFooterView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        
        [self loadFunctions];
    }
    
    return self;
}

/**
 *  Set background image
 */
//- (void)drawRect:(CGRect)rect {
//    [[UIImage imageNamed:@"mainCellBackground"] drawInRect:rect];
//}

#pragma mark - Data processing

/**
 *  Load new post data
 */
- (void)loadFunctions {
    // Request parameters
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"square";
    params[@"c"] = @"topic";
    
    // Send request
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wdeprecated-declarations"
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
        // Convert dictionary array to model array
        NSArray *functions = [TGMeFunctions mj_objectArrayWithKeyValuesArray:responseObject[@"square_list"]];
        
        // Create function part
        [self createFunctions:functions];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // Show failure reminder
        [SVProgressHUD showErrorWithStatus:@"Loading more functions failed"];
    }];
#pragma clang diagnostic pop
}

#pragma mark - Function part layout setup

/**
 *  Set up function part
 */
- (void)createFunctions:(NSArray *)functions {
    // Set the max columns of one row
    int maxCols = 6;
    
    // Set width and height
    CGFloat buttonW = TGScreenW / maxCols;
    CGFloat buttonH = buttonW;
    
    for (int i = 0; i < functions.count; i++) {
        // Create button
        TGMeFunctionButton *button = [TGMeFunctionButton buttonWithType:UIButtonTypeCustom];
        
        // Monitor button selection
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // Transmit model data
        button.function = functions[i];
        
        [self addSubview:button];
        
        // Calculate frame
        int col = i % maxCols;
        int row = i / maxCols;
        
        button.x = col * buttonW;
        button.y = row * buttonH;
        button.width = buttonW;
        button.height = buttonH;
        
        // Adjust footer height (Option 1)
        self.height = CGRectGetMaxY(button.frame);
    }
    
//    // Adjust footer height (Option 2)
//    // Calculate total rows
//    NSUInteger rows = functions.count / maxCols;
//    if (functions.count % maxCols != 0) {
//        rows++;
//    }
    
//    // Adjust footer height (Option 3)
//    NSUInteger rows = (functions.count + maxCols - 1) / maxCols;
    
//    // Calculate footer height
//    self.height = rows * buttonH;
    
    // Invoke drawRect: again to redraw rectangle
    [self setNeedsDisplay];
}

- (void)buttonClick:(TGMeFunctionButton *)button {
    TGLog(@"%@", button.function.url);
    if (![button.function.url hasPrefix:@"http"]) return;
    
    TGWebViewController *web = [[TGWebViewController alloc] init];
    web.url = button.function.url;
    web.title = button.function.name;
    
    // Acquire current navigation controller
    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navi = (UINavigationController *)tabBarVc.selectedViewController;
    [navi pushViewController:web animated:YES];
}

@end
