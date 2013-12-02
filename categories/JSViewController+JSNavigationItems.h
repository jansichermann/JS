#import "JSViewController.h"



/**
 Created by jan on 11/24/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSViewController (JSNavigationItems)
- (void)installNavigationCancelButtonWithFont:(UIFont *)font;
- (void)installNavigationCloseButton;
- (void)installNavigationActionButtonWithTitle:(NSString *)title
                              target:(id)target
                            selector:(SEL)selector;
@end
