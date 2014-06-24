#import "JSViewController+JSNavigationItems.h"
#import "UIBarButtonItem+JSButton.h"


@implementation JSViewController (JSNavigationItems)

- (void)installNavigationCancelButtonWithFont:(UIFont *)font {
    __weak JSViewController *weakSelf = self;
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem barButtonItemWithTitle:@"Cancel"
                                       font:font
                                 clickBlock:^{
                                     JSViewController *vc = weakSelf;
                                     [vc dismissSelfAnimated];
                                 }];
}

- (void)installNavigationCloseButtonWithFont:(UIFont *)font {
    __weak JSViewController *weakSelf = self;
    
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem barButtonItemWithTitle:@"Close"
                                       font:font
                                 clickBlock:
     ^{
         JSViewController *vc = weakSelf;
         [vc dismissSelfAnimated];
     }];
}

- (void)installLeftNavigationButtonWithTitle:(NSString *)title
                                        font:(UIFont *)font
                                   clickBlock:(void(^)())block {
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem barButtonItemWithTitle:title
                                       font:font
                                 clickBlock:block];

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
