#import <UIKit/UIKit.h>



/**
 Created by jan on 11/17/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSViewController : UIViewController
@property (nonatomic, readonly)         NSUInteger          appearanceCount;

/**
 @return Return YES if you want the view to be resized according to the keyboard
 */
- (BOOL)shouldObserveKeyboard;

- (void)reloadData;
- (void)dismissSelfAnimated;
@end
