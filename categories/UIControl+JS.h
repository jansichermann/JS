#import <UIKit/UIKit.h>
#import "JSEventBlockContainer.h"

/**
 Created by Jan Sichermann on 8/14/15. Copyright (c) 2015 Jan Sichermann. All rights reserved.
 */



@interface UIControl (JS)
- (void)addTarget:(TargetBlock)tb
 forControlEvents:(UIControlEvents)events;
@end
