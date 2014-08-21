#import <UIKit/UIKit.h>



/**
 Created by jan on 11/3/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
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
