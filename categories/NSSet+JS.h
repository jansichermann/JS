/**
 Created by jan on 4/30/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



#import <Foundation/Foundation.h>

@interface NSSet (JS)
- (NSSet *)setByRemovingObject:(NSObject *)obj;
- (NSSet *)setByRemovingObjects:(NSSet *)objects;
@end
