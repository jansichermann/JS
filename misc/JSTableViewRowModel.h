#import <Foundation/Foundation.h>
#import "JSTableViewController.h"



/**
 Created by jan on 11/18/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSTableViewRowModel : NSObject
<
JSTableViewRowModelProtocol
>
@property (nonatomic, copy, readonly)  OnClickBlock        onClickBlock;

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass;

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
                  onClick:(OnClickBlock)onClickBlock;
- (id)model;
- (Class)cellClass;

@end
