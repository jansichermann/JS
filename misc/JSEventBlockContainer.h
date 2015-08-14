#import <Foundation/Foundation.h>



/**
 Created by Jan Sichermann on 8/14/15. Copyright (c) 2015 Abacus. All rights reserved.
 */

typedef void(^TargetBlock)(id);

@interface JSEventBlockContainer : NSObject
+ (instancetype)withBlock:(TargetBlock)tb;
- (void)handleEvent:(id)sender;
@end
