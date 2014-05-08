#import "JS__NotificationCenter.h"
#import "NSObject+JS.h"
#import "NSSet+JS.h"




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

@end




@interface JS__NotificationCenter()

@property (atomic) NSSet *observers;

@end



@implementation JS__NotificationCenter
@synthesize observers = _observers;



- (NSSet *)observers {
    NSSet *s = nil;
    @synchronized(self.class) {
        s = _observers;
        if (!s) {
            s = [NSSet set];
            _observers = s;
        }
    }
    return s;
}

- (void)setObservers:(NSSet *)observers {
    @synchronized(self.class) {
        _observers = observers;
    }
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
    
    NSMutableSet *toRemove = [NSMutableSet setWithCapacity:self.observers.count];
    
    for (JS__NotificationObserverContainer *c in self.observers) {
        
        NSObject *strongObserver = c.observer;
        
        if (!strongObserver) {
            [toRemove addObject:c];
        }
        
        NSDictionary *d = strongObserver.__jsNotificationBlocks;
        
        JS__SingleParameterBlock b = d[notificationName];
        if (b) {
            if (![[NSThread currentThread] isMainThread]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    b(object);
                });
            }
            else {
                b(object);
            }
        }
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        self.observers = [self.observers setByRemovingObjects:toRemove.copy];
    });
}

@end
