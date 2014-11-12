#import <UIKit/UIKit.h>


/**
 Created by jan on 6/24/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface UISplitViewController (JS)
+ (instancetype)withViewControllers:(NSArray *)viewControllers;
- (void)setOnHideBlock:(void(^)(UIBarButtonItem *))b;
- (void)setOnShowBlock:(void(^)(UIBarButtonItem *))b;
@end
