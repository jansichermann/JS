#import "JSScrollView.h"
#import "UIView+JS.h"



@interface JSScrollView ()
<
UIScrollViewDelegate
>

@end



@implementation JSScrollView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    
    self.delegate = self;
    
    return self;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (self.didEndDeceleratingBlock) {
        self.didEndDeceleratingBlock(scrollView);
    }
}

- (NSUInteger)currentHorizontalPage {
    return self.contentOffset.x / self.width;
}


@end
