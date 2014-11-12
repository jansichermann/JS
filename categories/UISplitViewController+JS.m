#import "UISplitViewController+JS.h"
#import <objc/runtime.h>




static char const * const js__UISplitViewControllerWillHideBlockKey = "js__UISplitViewControllerWillHideBlockKey";
static char const * const js__UISplitViewControllerWillShowBlockKey = "js__UISplitViewControllerWillShowBlockKey";

@implementation UISplitViewController (JS)

+ (instancetype)withViewControllers:(NSArray *)viewControllers {
    UISplitViewController *sv = [[UISplitViewController alloc] init];
    sv.viewControllers = viewControllers;
    sv.delegate = (UISplitViewController<UISplitViewControllerDelegate> *)sv;
    return sv;
}

- (void)setOnHideBlock:(void(^)(UIBarButtonItem *))b {
    objc_setAssociatedObject(self,
                             js__UISplitViewControllerWillHideBlockKey,
                             b,
                             OBJC_ASSOCIATION_COPY);
}

- (void)setOnShowBlock:(void(^)(UIBarButtonItem *))b {
    objc_setAssociatedObject(self,
                             js__UISplitViewControllerWillShowBlockKey,
                             b,
                             OBJC_ASSOCIATION_COPY);
}

- (void)splitViewController:(UISplitViewController *)svc
     willHideViewController:(UIViewController *)aViewController
          withBarButtonItem:(UIBarButtonItem *)barButtonItem
       forPopoverController:(UIPopoverController *)pc {
    void(^b)(UIBarButtonItem *) =
    objc_getAssociatedObject(self,
                             js__UISplitViewControllerWillHideBlockKey);
    if (b) {
        b(barButtonItem);
    }
}

- (void)splitViewController:(UISplitViewController *)svc
     willShowViewController:(UIViewController *)aViewController
  invalidatingBarButtonItem:(UIBarButtonItem *)button {
    void(^b)(UIBarButtonItem *) =
    objc_getAssociatedObject(self,
                             js__UISplitViewControllerWillShowBlockKey);
    if (b) {
        b(button);
    }
}

@end
