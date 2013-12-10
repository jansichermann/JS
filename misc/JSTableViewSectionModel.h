#import <Foundation/Foundation.h>
#import "JSTableViewController.h"


/**
 Created by jan on 11/18/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSTableViewSectionModel : NSObject
<
JSTableViewSectionModelProtocol
>

/**
 *-----
 @name Initializers
 *-----
 */
+ (instancetype)sectionWithRows:(NSArray *)rows;

- (void)setSectionHeaderViewWithAttributedTitle:(NSAttributedString *)title
                               topBottomPadding:(CGFloat)padding
                                backgroundColor:(UIColor *)color;
- (void)addRow:(NSObject <JSTableViewRowModelProtocol> *)row;

/**
 *-----
 @name Protocol Functions
 *-----
 */
- (NSObject <JSTableViewRowModelProtocol> *)modelAtRow:(NSUInteger)row;
- (NSInteger)count;
- (UIView *)sectionHeaderView;

@end
