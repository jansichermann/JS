#import <UIKit/UIKit.h>



/**
 Created by jan on 12/3/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface UIScrollView (JS)

- (void)scrollToBottomWithCompletionBlock:(void(^)(BOOL finished))completionBlock;

@end
