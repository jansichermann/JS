#import "NSObject+JS.h"
#import "NSDictionary+JS.h"
#import <objc/runtime.h>
#import "JS__NotificationObserverContainer.h"



static char const * const js__ObserverContainersKey = "js__ObserverContainersKey";


@implementation NSObject (JS)


- (void)executeAfterTimeInterval:(CGFloat)seconds
                           block:(void(^)())block {
    
    if (!block){
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), block);
}

#pragma mark - NSNotificationCenter Observing

- (void)observeNotificationCenter:(NSNotificationCenter *)center
                              key:(NSString *)notificationKey
                    withFireBlock:(void(^)(id))fireBlock {
    
    JS__NotificationObserverContainer *container =
    [JS__NotificationObserverContainer notificationCenter:center
                                              keyObserver:self
                                                   forKey:notificationKey
                                                fireBlock:fireBlock];
    [self _addObserverContainer:container];
}


#pragma mark - KVO
- (void)observe:(NSObject *)observant
        keyPath:(NSString *)keyPath
      fireBlock:(void(^)(id newValue))fireBlock {
    
    [self _addObserverContainer:
     [JS__NotificationObserverContainer kvObserver:self
                                       onObservant:observant
                                        forKeyPath:keyPath
                              convenienceFireBlock:fireBlock]
     ];
}

- (void)observe:(NSObject *)observant
     forKeyPath:(NSString *)keyPath
        options:(NSKeyValueObservingOptions)options
      fireBlock:(void(^)(NSString *keyPath, NSDictionary *change))fireBlock {
    
    [self _addObserverContainer:
     [JS__NotificationObserverContainer kvObserver:self
                                       onObservant:observant
                                        forKeyPath:keyPath
                                           options:options
                                         fireBlock:fireBlock]
     ];
}

- (void)_addObserverContainer:(JS__NotificationObserverContainer *)container {
    NSArray *observerContainers = self.observerContainers;
    [self _setObserverContainers:[observerContainers arrayByAddingObject:container]];
}

- (NSArray *)observerContainers {
    NSArray *arr = objc_getAssociatedObject(self,
                                            js__ObserverContainersKey);
    return arr ? arr : @[];
}

- (void)removeAllObservations {
    [self _setObserverContainers:nil];
}

- (void)_setObserverContainers:(NSArray *)containers {
    objc_setAssociatedObject(self,
                             js__ObserverContainersKey,
                             containers,
                             OBJC_ASSOCIATION_RETAIN);
}


@end
