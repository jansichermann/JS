#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 Created by jan on 4/28/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface NSObject (JS)

- (void)executeAfterTimeInterval:(CGFloat)seconds
                           block:(void(^)())block;

- (void)observeNotificationCenter:(NSNotificationCenter *)center
                              key:(NSString *)notificationKey
                    withFireBlock:(void(^)(NSString *, NSDictionary *))fireBlock;

- (void)observe:(NSObject *)observant
     forKeyPath:(NSString *)keyPath
        options:(NSKeyValueObservingOptions)options
      fireBlock:(void(^)(NSString *, NSDictionary *))fireBlock;

- (void)removeAllObservations;

@end
