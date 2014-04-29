#import <UIKit/UIKit.h>



/**
 Created by jan on 4/24/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



typedef void(^JSUIControlBlock)(UIControl *c);

@interface UIControl (JS)

- (void)js__setTouchUpInsideBlock:(JSUIControlBlock)block;
- (void)js__setValueChangedBlock:(JSUIControlBlock)block;

@end
