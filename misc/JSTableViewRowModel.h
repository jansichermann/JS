#import <Foundation/Foundation.h>
#import "JSTableViewController.h"



/**
 Created by jan on 11/18/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSTableViewRowModel : NSObject
<
JSTableViewRowModelProtocol
>
@property (nonatomic, copy, readonly)   OnClickBlock        onClickBlock;

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass;

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
           selectionStyle:(UITableViewCellSelectionStyle)style;

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
          backgroundColor:(UIColor *)bgColor;

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
          backgroundColor:(UIColor *)bgColor
           selectionStyle:(UITableViewCellSelectionStyle)style;

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
                  onClick:(OnClickBlock)onClickBlock;

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
          backgroundColor:(UIColor *)bgColor
                  onClick:(OnClickBlock)onClickBlock;

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
          backgroundColor:(UIColor *)bgColor
           selectionStyle:(UITableViewCellSelectionStyle)style
                  onClick:(OnClickBlock)onClickBlock;

- (id)model;
- (Class)cellClass;
- (UIColor *)cellBackgroundColor;
- (UITableViewCellSelectionStyle)selectionStyle;

@end
