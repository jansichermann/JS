#import <UIKit/UIKit.h>
#import "JSBase.h"


/**
 Created by jan on 6/24/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface UISplitViewController (JS)
+ (instancetype)withViewControllers:(NSArray *)viewControllers;
- (void)setOnHideBlock:(JS__BarButtonItemBlock)b;
- (void)setOnShowBlock:(JS__BarButtonItemBlock)b;
@end
