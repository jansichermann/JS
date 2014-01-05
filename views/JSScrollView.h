#import <UIKit/UIKit.h>



@class JSScrollView;



typedef void(^JSScrollViewDelegateBlock)(JSScrollView *sv);



/**
 Created by jan on 1/4/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface JSScrollView : UIScrollView

@property (nonatomic, copy)         JSScrollViewDelegateBlock       didEndDeceleratingBlock;

- (NSUInteger)currentHorizontalPage;

@end
