#import "UIControl+JS.h"
#import <objc/runtime.h>


static char const * const js__TargetContainersKey = "js__TargetContainersKey";

@implementation UIControl (JS)

- (void)addTarget:(TargetBlock)tb
 forControlEvents:(UIControlEvents)events {
    
    JSEventBlockContainer *c = [JSEventBlockContainer withBlock:tb];
    
    [self addTarget:c
             action:@selector(handleEvent:)
   forControlEvents:events];
    
    [self _addTargetContainer:c];
}

- (void)_addTargetContainer:(JSEventBlockContainer *)tc {
    NSArray *tbs = self.targetBlocks;
    [self _setTargetContainers:[tbs arrayByAddingObject:tc]];
}

- (NSArray *)targetBlocks {
    NSArray *arr = objc_getAssociatedObject(self,
                                            js__TargetContainersKey);
    return arr ? arr : @[];
}

- (void)removeAllTargets {
    [self _setTargetContainers:nil];
}

- (void)_setTargetContainers:(NSArray *)containers {
    objc_setAssociatedObject(self,
                             js__TargetContainersKey,
                             containers,
                             OBJC_ASSOCIATION_RETAIN);
}

@end
