#import "JSPageControl.h"



@implementation JSPageControl

- (void)setSelectionBlock:(JSPageControlOnSelection)selectionBlock {
    _selectionBlock = [selectionBlock copy];
    [self addTarget:self
             action:@selector(selectionChanged:)
   forControlEvents:UIControlEventTouchUpInside];
}

- (void)selectionChanged:(UIPageControl *)pc {
    if (self.selectionBlock) {
        self.selectionBlock((NSUInteger)pc.currentPage);
    }
}

@end
