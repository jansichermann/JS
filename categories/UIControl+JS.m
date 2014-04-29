#import "UIControl+JS.h"
#import <objc/runtime.h>



static char const * const js__OnTouchUpInsideBlockKey = "js__OnTouchUpInsideBlockKey";
static char const * const js__ValueChangedBlockKey = "js__ValueChangedBlockKey";



@implementation UIControl (JS)

- (void)js__setTouchUpInsideBlock:(JSUIControlBlock)block {
    [self __setJSTouchUpInsideBlock:block];
    [self addTarget:self
             action:@selector(__jsTouchUpInsideAction)
   forControlEvents:UIControlEventTouchUpInside];
}

- (void)__setJSTouchUpInsideBlock:(JSUIControlBlock)block {
    objc_setAssociatedObject(self,
                             js__OnTouchUpInsideBlockKey,
                             block,
                             OBJC_ASSOCIATION_COPY);
}

- (JSUIControlBlock)__jsTouchUpInsideBlock {
    return objc_getAssociatedObject(self,
                                    js__OnTouchUpInsideBlockKey);
}

- (void)__jsTouchUpInsideAction {
    if (self.__jsTouchUpInsideBlock) {
        self.__jsTouchUpInsideBlock(self);
    }
}



- (void)js__setValueChangedBlock:(JSUIControlBlock)block {
    [self __setJSValueChangedBlock:block];
    [self addTarget:self
             action:@selector(__jsValueChangedAction)
   forControlEvents:UIControlEventValueChanged];
}

- (void)__setJSValueChangedBlock:(JSUIControlBlock)block {
    objc_setAssociatedObject(self,
                             js__ValueChangedBlockKey,
                             block,
                             OBJC_ASSOCIATION_COPY);
}

- (JSUIControlBlock)__jsValueChangedBlock {
    return objc_getAssociatedObject(self,
                                    js__ValueChangedBlockKey);
}

- (void)__jsValueChangedAction {
    if (self.__jsValueChangedBlock) {
        self.__jsValueChangedBlock(self);
    }
}

@end
