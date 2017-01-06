//
//  TGPostViewController.h
//  MyWeibo
//
//  Created by Theodore Guo on 6/1/17.
//  Copyright © 2017 Theodore Guo. All rights reserved.
//  Basic post view controller

#import <UIKit/UIKit.h>

@interface TGPostViewController : UITableViewController

/**
 *  Post type (make subclass implement)
 *
 *  @return type value
 */
- (NSString *)type;

@end
