#import "UIScrollView+JS.h"
#import "UIView+JS.h"


@implementation UIScrollView (JS)

- (void)scrollToBottomWithCompletionBlock:(void(^)(BOOL finished))completionBlock {
    [UIView animateWithDuration:0.3
                     animations:^{
                         self.contentOffset = CGPointMake(0, self.contentSize.height - self.height);
                     }
                     completion:completionBlock];
}

@end
