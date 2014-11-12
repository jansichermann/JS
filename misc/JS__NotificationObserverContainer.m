#import "JS__NotificationObserverContainer.h"
#import "NSDictionary+JS.h"
#import <objc/runtime.h>


@interface JS__NotificationObserverContainer()
@property (nonatomic, copy) void(^fireBlock)(id);
@property (nonatomic, copy) void(^kvoFireBlock)(NSString *, NSDictionary *);
@property (nonatomic) NSString *observantKeyPath;
@end



@implementation JS__NotificationObserverContainer

+ (instancetype)_withObserver:(NSObject *)observer {
    JS__NotificationObserverContainer *c = [[JS__NotificationObserverContainer alloc] init];
    c.observer = observer;
    return c;
}

+ (instancetype)notificationCenter:(NSNotificationCenter *)center
                    keyObserver:(NSObject *)observer
                            forKey:(NSString *)key
                         fireBlock:(void(^)(id))fireBlock {
    
    JS__NotificationObserverContainer *c = [self _withObserver:observer];
    
    [center addObserver:c
               selector:@selector(_notificationFired:)
                   name:key
                 object:nil];
    
    c.fireBlock = fireBlock;

    return c;
}

+ (instancetype)kvObserver:(NSObject *)observer
                onObservant:(NSObject *)observant
                forKeyPath:(NSString *)keyPath
                   options:(NSKeyValueObservingOptions)options
                 fireBlock:(void(^)(NSString *, NSDictionary *))fireBlock {
    
    NSParameterAssert(observer);
    NSParameterAssert(observant);
    NSParameterAssert(keyPath);
    NSParameterAssert(fireBlock);
    
    if (!observer) {
        return nil;
    }
    
    JS__NotificationObserverContainer *c = [self _withObserver:observer];
    c.observant = observant;
    c.observantKeyPath = keyPath;
    c.kvoFireBlock = fireBlock;
    
    [observant addObserver:c
                forKeyPath:keyPath
                   options:options
                   context:nil];

    return c;
}

- (BOOL)isEqual:(JS__NotificationObserverContainer *)object {
    if (self == object) {
        return YES;
    }
    
    if (![self isKindOfClass:[object class]]) {
        return NO;
    }
    
    NSObject *strongObserver = self.observer;
    return [strongObserver isEqual:object.observer];
}

- (NSUInteger)hash {
    NSObject *strongObserver = self.observer;
    return strongObserver.hash;
}

- (void)_notificationFired:(NSNotification *)notif {
    // this can only fire while the observer is actually alive
    // once the observer deallocs, the container's retain count should
    // reach 0 and it itself will dealloc as well.
    if (self.fireBlock) {
        self.fireBlock(notif.object);
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    if (self.observant && self.observantKeyPath) {
        [self.observant removeObserver:self
                            forKeyPath:self.observantKeyPath];
    }
}


#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    // same story here: This can only fire if the observant changed, by definition
    // it still lives.
    // This instance itself also only survives if the observer lives, as it retains
    // this instsance. 
    if (self.kvoFireBlock) {
        self.kvoFireBlock(keyPath, change);
    }
}

@end
