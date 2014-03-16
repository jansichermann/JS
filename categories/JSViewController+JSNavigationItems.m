#import "JSViewController+JSNavigationItems.h"
#import "UIBarButtonItem+JSButton.h"


@implementation JSViewController (JSNavigationItems)

- (void)installNavigationCancelButtonWithFont:(UIFont *)font {
    WEAK(self);
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem barButtonItemWithTitle:@"Cancel"
                                       font:font
                                 clickBlock:^{
                                     JSViewController *vc = weak_self;
                                     [vc dismissSelfAnimated];
                                 }];
}

- (void)installNavigationCloseButtonWithFont:(UIFont *)font {
    WEAK(self);
    self.navigationItem.leftBarButtonItem =
    [UIBarButtonItem barButtonItemWithTitle:@"Close"
                                       font:font
                                 clickBlock:
     ^{
         JSViewController *vc = weak_self;
         [vc dismissSelfAnimated];
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
