#import <UIKit/UIKit.h>
#import "JSTableViewController.h"


typedef void(^ConfigureBlock)(id model);
typedef void(^PrepareForReuseBlock)();


/**
 Created by jan on 11/18/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 
 A generic Table View Cell that conforms to JSTableViewCellProtocol.
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
@property (nonatomic, copy) PrepareForReuseBlock    prepareForReuseBlock;

/**
 A reference to the UITableView within which this cell is being displayed
 */
@property (nonatomic, weak) UITableView             *parentTableView;

+ (CGFloat)heightForModel:(id)model
              inTableView:(UITableView *)tableView;
- (void)configureWithModel:(id)model;


@end
