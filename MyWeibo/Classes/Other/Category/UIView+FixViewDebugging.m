//
//  UIView+FixViewDebugging.m
//  MyWeibo
//
//  Created by Theodore Guo on 25/12/16.
//  Copyright © 2016 Theodore Guo. All rights reserved.
//

#ifdef DEBUG

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "UIView+FixViewDebugging.h"

@implementation UIView (FixViewDebugging)

/*
 To fix failure "[UIWindow viewForFirstBaselineLayout]: unrecognized selector sent to instance xxx" while debugging view hierarchy in Xcode 7.3. Fails on simulator iOS 8.1/8.4. 9.3 works fine.
 
 When your project loads, the load method will execute, causing viewForFirstBaselineLayout and viewForLastBaselineLayout to use the viewForBaselineLayout implementation if they are not currently implemented, so view debugging gets iOS8 flavor the behavior it was looking for.

To add this to your own project, create a new empty Objective-C file in your project and paste the contents in. You can name it whatever you want. I call mine "UIView+FixViewDebugging". If you are in a pure Swift project you do not need to create a bridging header. The file will be compiled into your project and you don't need to reference it.

Note this will only work for debug builds because of the #ifdef DEBUG. You can remove it but then you may accidentally compile this into your release builds (though it should have no ill side effects).
*/
+ (void)load
{
    Method original = class_getInstanceMethod(self, @selector(viewForBaselineLayout));
    class_addMethod(self, @selector(viewForFirstBaselineLayout), method_getImplementation(original), method_getTypeEncoding(original));
    class_addMethod(self, @selector(viewForLastBaselineLayout), method_getImplementation(original), method_getTypeEncoding(original));
}

@end

#endif
