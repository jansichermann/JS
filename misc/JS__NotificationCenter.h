#import <Foundation/Foundation.h>
#import "JSBase.h"


/**
 Created by jan on 4/28/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface JS__NotificationCenter : NSObject

- (void)registerObserver:(NSObject *)observer
         forNotification:(NSString *)notificationName
           withFireBlock:(JS__SingleParameterBlock)fireBlock;

- (void)fireNotification:(NSString *)notificationName
              withObject:(NSObject *)object;

@end
