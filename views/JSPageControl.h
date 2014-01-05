#import <UIKit/UIKit.h>


typedef void(^JSPageControlOnSelection)(NSUInteger selectedIndex);
/**
 Created by jan on 1/4/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface JSPageControl : UIPageControl
@property (nonatomic, copy) JSPageControlOnSelection        selectionBlock;
@end
