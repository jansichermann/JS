#import <UIKit/UIKit.h>



/**
 Created by jan on 11/3/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface UIView (JS)
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;
- (CGFloat)right;
- (CGFloat)verticalCenter;
- (CGFloat)horizontalCenter;
- (CGFloat)left;
- (void)setLeft:(CGFloat)left;
- (CGFloat)top;
- (void)setTop:(CGFloat)top;
- (void)setWidth:(CGFloat)width;
- (CGFloat)width;
- (void)setRight:(CGFloat)right;
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;
- (void)centerInSuperview;
- (void)centerHorizontallyInSuperview;
- (void)centerVerticallyInSuperview;
- (UIImage *)snapshot;
@end
