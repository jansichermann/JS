#import <UIKit/UIKit.h>



/**
 Created by jan on 11/17/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
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
@property (nonatomic, copy) JS__VoidBlock onViewDidAppearBlock;

@property (nonatomic, copy) JS__VoidBlock onViewWillDisappearBlock;

/**
 @return Return YES if you want the view to be resized according to the keyboard
 */
- (BOOL)shouldObserveKeyboard;

/**
 @discussion Calls dismissViewControllerAnimated:completion: with the arguments YES and nil.
 */
- (void)dismissSelfAnimated;
@end
