#import <Foundation/Foundation.h>
#import "JSBase.h"


/**
 Created by jan on 4/28/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface NSObject (JS)

- (void)executeAfterTimeInterval:(CGFloat)seconds
                           block:(JS__VoidBlock)block;

- (void)observeNotificationCenter:(NSNotificationCenter *)center
                              key:(NSString *)notificationKey
                    withFireBlock:(JS__SingleParameterBlock)fireBlock;

- (void)observe:(NSObject *)observant
     forKeyPath:(NSString *)keyPath
        options:(NSKeyValueObservingOptions)options
      fireBlock:(JS__StringDictBlock)fireBlock;

- (void)removeAllObservations;

@end
