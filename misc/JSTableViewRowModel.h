#import <Foundation/Foundation.h>
#import "JSTableViewController.h"



/**
 Created by jan on 11/18/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.

 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 */



@interface JSTableViewRowModel : NSObject
<
JSTableViewRowModelProtocol
>
@property (nonatomic, copy)   OnClickBlock        onClickBlock;
@property (nonatomic, readonly) id                          model;
@property (nonatomic, readonly) Class                       cellClass;
@property (nonatomic, readonly) UIColor                     *cellBackgroundColor;
@property (nonatomic, readonly) UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic, readonly) UITableViewCellEditingStyle editingStyle;
@property (nonatomic, readwrite)BOOL                        hidden;

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

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
          backgroundColor:(UIColor *)bgColor
           selectionStyle:(UITableViewCellSelectionStyle)style
             editingStyle:(UITableViewCellEditingStyle)editingStyle
                  onClick:(OnClickBlock)onClickBlock;
@end
