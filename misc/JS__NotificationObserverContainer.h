#import <Foundation/Foundation.h>



/**
 Created by jan on 7/3/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */

@interface JS__NotificationObserverContainer : NSObject

+ (instancetype)kvObserver:(NSObject *)observer
               onObservant:(NSObject *)observant
                forKeyPath:(NSString *)keyPath
                   options:(NSKeyValueObservingOptions)options
                 fireBlock:(void(^)(NSString *, NSDictionary *))fireBlock;

+ (instancetype)kvObserver:(NSObject *)observer
               onObservant:(NSObject *)observant
                forKeyPath:(NSString *)keyPath
      convenienceFireBlock:(void(^)(NSObject *newValue))fireBlock;

+ (instancetype)notificationCenter:(NSNotificationCenter *)center
                       keyObserver:(NSObject *)observer
                            forKey:(NSString *)key
                         fireBlock:(void(^)(id))fireBlock;
@end

