#import "UILabel+JS.h"
#import "UIView+JS.h"



@implementation UILabel (JS)

- (void)sizeToFitWidth:(CGFloat)width {
    CGSize size = [self sizeThatFits:CGSizeMake(width, INT32_MAX)];
    self.frame = CGRectMake(self.left,
                            self.top,
                            size.width,
                            size.height);
}

@end
