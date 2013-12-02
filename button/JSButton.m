#import "JSButton.h"

@interface JSButton()

@property (nonatomic, copy)         JSButtonActionBlock         touchUpInsideBlock;

@end



@implementation JSButton

- (void)setTouchUpInsideBlock:(JSButtonActionBlock)block {
    _touchUpInsideBlock = block;
    [self addTarget:self
         action:@selector(touchUpInsideAction)
   forControlEvents:UIControlEventTouchUpInside];
}

- (void)touchUpInsideAction {
    if (self.touchUpInsideBlock) {
        self.touchUpInsideBlock(self);
    }
}

@end
