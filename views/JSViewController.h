#import <UIKit/UIKit.h>



/**
 Created by jan on 11/17/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.

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



@interface JSViewController : UIViewController
/**
 @return Returns the number of times this instance's viewDidAppear: method was called.
 This count is incremented prior to any other code being executed in the viewDidAppear: method
 */
@property (nonatomic, readonly)         NSUInteger          appearanceCount;

/**
 @discussion Set this block which will be executed on viewDidAppear:.
 */
@property (nonatomic, copy) void(^onViewDidAppearBlock)();

@property (nonatomic, copy) void(^onViewWillDisappearBlock)();

@property (nonatomic, copy) void(^onViewDidLoadBlock)();

@property (nonatomic, copy) void(^onViewWillAppearBlock)();

/**
 @return Return YES if you want the view to be resized according to the keyboard
 */
- (BOOL)shouldObserveKeyboard;

/**
 @discussion Calls dismissViewControllerAnimated:completion: with the arguments YES and nil.
 */
- (void)dismissSelfAnimated;
@end
