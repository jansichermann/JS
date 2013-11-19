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


/**
 *-----
 @name Protocol Functions
 *-----
 */
- (NSObject <JSTableViewRowModelProtocol> *)modelAtRow:(NSUInteger)row;
- (void)addRow:(NSObject <JSTableViewRowModelProtocol> *)row;
- (NSInteger)count;

@end
