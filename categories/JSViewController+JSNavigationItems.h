#import "JSViewController.h"



/**
 Created by jan on 11/24/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSViewController (JSNavigationItems)
- (void)installNavigationCancelButtonWithFont:(UIFont *)font;
- (void)installNavigationCloseButtonWithFont:(UIFont *)font;
- (void)installRightNavigationButtonWithTitle:(NSString *)title
                                         font:(UIFont *)font
                                   clickBlock:(void(^)())block;
@end
