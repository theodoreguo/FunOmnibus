//
//  TGLoginRegisterViewController.m
//  MyWeibo
//
//  Created by Theodore Guo on 30/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#import "TGLoginRegisterViewController.h"

@interface TGLoginRegisterViewController ()

//@property (weak, nonatomic) IBOutlet UIButton *loginButton;
//@property (weak, nonatomic) IBOutlet UITextField *usernameField;

// Login view left margin to superview
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginViewLeftMargin;

@end

@implementation TGLoginRegisterViewController

// Close login or register interface
- (IBAction)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
    // Adjust text field corner
    self.loginButton.layer.cornerRadius = 5;
    self.loginButton.layer.masksToBounds = YES;
    */
    
    /*
    // Text attribute
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // NSAttributedString:string with attributes (rich text technology)
    NSAttributedString *placeholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:attrs];
    self.usernameField.attributedPlaceholder = placeholder;
    */
    
    /*
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:@"Username"];
    [placeholder setAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} range:NSMakeRange(0, 7)];
    self.usernameField.attributedPlaceholder = placeholder;
    */
}

// Show register dialog
- (IBAction)showLoginOrRegister:(UIButton *)button {
    // Hide keyboard
    [self.view endEditing:YES];
    
    if (self.loginViewLeftMargin.constant == 0) { // Show register dialog
        self.loginViewLeftMargin.constant = - self.view.width;
        button.selected = YES;
//        [button setTitle:@"Login" forState:UIControlStateNormal];
    } else { // Show login dialog
        self.loginViewLeftMargin.constant = 0;
        button.selected = NO;
//        [button setTitle:@"Sign Up" forState:UIControlStateNormal];
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *  Set white color for current controller's status bar
 *
 *  @return white color content
 */
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

@end
