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

- (void)installNavigationCloseButton {
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(dismissSelfAnimated)];
    
}

- (void)installNavigationActionButtonWithTitle:(NSString *)title
                              target:(id)target
                            selector:(SEL)selector {
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:title
                                     style:UIBarButtonItemStylePlain
                                    target:target
                                    action:selector];
}

@end
