#import "NSObject+JS.h"
#import <objc/runtime.h>
#import "NSDictionary+JS.h"



static char const * const js__NotificationBlocksKey = "js__NotificationBlocksKey";



@implementation NSObject (JS)


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
