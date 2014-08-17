#import "UIScrollView+JS.h"
#import "UIView+JS.h"


@implementation UIScrollView (JS)

- (void)scrollToBottomWithCompletionBlock:(void(^)(BOOL finished))completionBlock {
    if (self.contentSize.height < self.height) {
        return;
    }
    
    __weak UIScrollView *weakSelf = self;
    
    CGFloat newHeight = self.contentSize.height - self.height;
    
    [UIView animateWithDuration:0.3
                     animations:
     ^{
         UIScrollView *strongSelf = weakSelf;
         strongSelf.contentOffset = CGPointMake(0, newHeight);
     }
                     completion:completionBlock];
}

@end
