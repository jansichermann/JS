#import <Foundation/Foundation.h>
#import "JSBase.h"


/**
 Created by jan on 4/28/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface NSObject (JS)

- (void)executeAfterTimeInterval:(CGFloat)seconds
                           block:(void(^)())block;

- (void)__setNotificationBlock:(JS__SingleParameterBlock)block
               forNotification:(NSString *)notificationName;

- (NSDictionary *)__jsNotificationBlocks;

@end
