#import "JSViewController+JSNavigationItems.h"

@implementation JSViewController (JSNavigationItems)

- (void)installNavigationCancelButton {
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:@"Cancel"
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(dismissSelfAnimated)];

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
