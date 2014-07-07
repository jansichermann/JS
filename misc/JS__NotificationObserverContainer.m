#import "JS__NotificationObserverContainer.h"
#import "JSBase.h"
#import "NSDictionary+JS.h"
#import <objc/runtime.h>


@interface JS__NotificationObserverContainer()
@property (nonatomic, copy) JS__SingleParameterBlock fireBlock;
@property (nonatomic, copy) JS__StringDictBlock kvoFireBlock;
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
                         fireBlock:(JS__SingleParameterBlock)fireBlock {
    
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
                 fireBlock:(JS__StringDictBlock)fireBlock {
    
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
    if (!self.observer) {
        // do something, i.e. remove block and self
    }
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
    if (!self.observer) {
        // do something
    }
    if (self.kvoFireBlock) {
        self.kvoFireBlock(keyPath, change);
    }
}

@end
