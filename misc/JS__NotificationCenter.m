#import "JS__NotificationCenter.h"
#import "NSObject+JS.h"




@interface JS__NotificationObserverContainer : NSObject

@property (nonatomic, weak) NSObject *observer;
+ (instancetype)withObserver:(NSObject *)observer;

@end



@implementation JS__NotificationObserverContainer

+ (instancetype)withObserver:(NSObject *)observer {
    if (!observer) {
        return nil;
    }
    JS__NotificationObserverContainer *c = [[JS__NotificationObserverContainer alloc] init];
    c.observer = observer;
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

- (void)dealloc {
    NSLog(@"deallocing observer container");
}


@end




@interface JS__NotificationCenter()

@property (nonatomic) NSSet *observers;

@end



@implementation JS__NotificationCenter

- (NSSet *)observers {
    if (!_observers) {
        _observers = [NSSet set];
    }
    return _observers;
}


- (void)registerObserver:(NSObject *)observer
         forNotification:(NSString *)notificationName
           withFireBlock:(JS__SingleParameterBlock)fireBlock {

    JS__NotificationObserverContainer *c =
    [JS__NotificationObserverContainer withObserver:observer];
    
    [observer __setNotificationBlock:fireBlock
                     forNotification:notificationName];
    
    self.observers = [self.observers setByAddingObject:c];
}


- (void)fireNotification:(NSString *)notificationName
              withObject:(NSObject *)object {
    
    for (JS__NotificationObserverContainer *c in self.observers) {

        NSObject *strongObserver = c.observer;
        NSDictionary *d = strongObserver.__jsNotificationBlocks;
        
        JS__SingleParameterBlock b = d[notificationName];
        if (b) {
            b(object);
        }
    }
    
}

@end
