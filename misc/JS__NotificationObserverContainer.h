#import <Foundation/Foundation.h>
#import "JSBase.h"



/**
 Created by jan on 7/3/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */

@interface JS__NotificationObserverContainer : NSObject

@property (nonatomic, weak) NSObject *observer;
@property (nonatomic, weak) NSObject *observant;

+ (instancetype)kvObserver:(NSObject *)observer
               onObservant:(NSObject *)observant
                forKeyPath:(NSString *)keyPath
                   options:(NSKeyValueObservingOptions)options
                 fireBlock:(JS__StringDictBlock)fireBlock;


+ (instancetype)notificationCenter:(NSNotificationCenter *)center
                       keyObserver:(NSObject *)observer
                            forKey:(NSString *)key
                         fireBlock:(JS__SingleParameterBlock)fireBlock;
@end

