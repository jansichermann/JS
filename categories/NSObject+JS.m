#import "NSObject+JS.h"
#import <objc/runtime.h>
#import "NSDictionary+JS.h"



static char const * const js__NotificationBlocksKey = "js__NotificationBlocksKey";



@implementation NSObject (JS)

- (void)observe:(NSString *)observationName
      fireBlock:(JS__SingleParameterBlock)fireBlock {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:observationName
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(_notificationFired:)
                                                 name:observationName
                                               object:nil];
    [self __setNotificationBlock:fireBlock
                 forNotification:observationName];
}

- (void)_notificationFired:(NSNotification *)notif {
    NSDictionary *notificationBlocks = self.__jsNotificationBlocks;
    JS__SingleParameterBlock b = [notificationBlocks objectForKey:notif.name];
    if (b) {
        b(notif.object);
    }
}

- (void)executeAfterTimeInterval:(CGFloat)seconds
                           block:(void(^)())block {
    
    if (!block){
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        [NSThread sleepForTimeInterval:seconds];
        dispatch_async(dispatch_get_main_queue(), ^{
            block();
        });
    });
}

- (void)__setNotificationBlock:(JS__SingleParameterBlock)block
               forNotification:(NSString *)notificationName {
    
    NSDictionary *d = self.__jsNotificationBlocks;
    
    if (block) {
        d = [d dictionaryBySettingObject:block
                                  forKey:notificationName];
    }
    else {
        d = [d dictionaryByRemovingObjectForKey:notificationName];
    }
    
    objc_setAssociatedObject(self,
                             js__NotificationBlocksKey,
                             d,
                             OBJC_ASSOCIATION_RETAIN);
}

- (NSDictionary *)__jsNotificationBlocks {
    NSDictionary *d = objc_getAssociatedObject(self,
                                    js__NotificationBlocksKey);
    if (!d) {
        return @{};
    }
    return d;
}

@end
