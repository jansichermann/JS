#import <UIKit/UIKit.h>

@class JSButton;
typedef void(^JSButtonActionBlock)(JSButton *b);


/**
 Created by jan on 11/29/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSButton : UIButton

- (void)setTouchUpInsideBlock:(JSButtonActionBlock)block;

@end
