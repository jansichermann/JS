#import <Foundation/Foundation.h>



/**
 Created by jan on 2/19/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface NSDictionary (JS)
- (NSDictionary *)dictionaryBySettingObject:(NSObject *)object
                                     forKey:(id)key;
- (NSDictionary *)dictionaryByRemovingObjectForKey:(NSString *)key;
@end
