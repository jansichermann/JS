#import <UIKit/UIKit.h>



/**
 Created by jan on 11/17/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSViewController : UIViewController
/**
 @return Returns the number of times this instance's viewDidAppear: method was called.
 */
@property (nonatomic, readonly)         NSUInteger          appearanceCount;

/**
 @return Return YES if you want the view to be resized according to the keyboard
 */
- (BOOL)shouldObserveKeyboard;

/**
 @discussion A generic reload method to be overridden by subclasses.
 */
- (void)reloadData;

/**
 @discussion Calls dismissViewControllerAnimated:completion: with the arguments YES and nil.
 */
- (void)dismissSelfAnimated;
@end
