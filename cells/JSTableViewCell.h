#import <UIKit/UIKit.h>
#import "JSTableViewController.h"


typedef void(^ConfigureBlock)(id model);


/**
 Created by jan on 11/18/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 
 A generic Table View Cell that conforms to JSTableViewCellProtocol.
 
 
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



@interface JSTableViewCell : UITableViewCell
<
JSTableViewCellProtocol
>

/**
 Called prior to display. This is meant to do any configuration of the UI
 that depends on the model.
 */
@property (nonatomic, copy) ConfigureBlock          configureBlock;

/**
 Called prior to the cell being recycled. This is meant to unset any UI content
 that is based on the underlying model representation
 */
@property (nonatomic, copy) void(^prepareForReuseBlock)();

/**
 Called to layout subviews
 */
@property (nonatomic, copy) void(^layoutSubviewsBlock)();

/**
 A reference to the UITableView within which this cell is being displayed
 */
@property (nonatomic, weak) UITableView             *parentTableView;

+ (CGFloat)heightForModel:(id)model
              inTableView:(UITableView *)tableView;
- (void)configureWithModel:(id)model;


@end
