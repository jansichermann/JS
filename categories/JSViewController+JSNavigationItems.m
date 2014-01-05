#import "JSViewController+JSNavigationItems.h"
#import "UIBarButtonItem+JSButton.h"


@implementation JSViewController (JSNavigationItems)

- (void)installNavigationCancelButtonWithFont:(UIFont *)font {
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem barButtonItemWithTitle:@"Cancel"
                                       font:font
                                 clickBlock:^{
                                     [self dismissSelfAnimated];
                                 }];
}

- (void)installNavigationCloseButtonWithFont:(UIFont *)font {
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTitle:@"Close"
                                                                               font:font
                                                                         clickBlock:^{
                                                                             [self dismissSelfAnimated];
                                                                         }];
    
}

- (void)installRightNavigationButtonWithTitle:(NSString *)title
                                         font:(UIFont *)font
                                   clickBlock:(void(^)())block {
    self.navigationItem.rightBarButtonItem =
    [UIBarButtonItem barButtonItemWithTitle:title
                                       font:font
                                 clickBlock:block];
}

@end
