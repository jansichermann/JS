#import <UIKit/UIKit.h>
#import "JSTableViewController.h"



/**
 Created by jan on 11/18/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.\
 */



@interface JSTableViewCell : UITableViewCell
<
JSTableViewCellProtocol
>

+ (CGFloat)heightForModel:(id)model
              inTableView:(UITableView *)tableView;
- (void)configureWithModel:(id)model;


@end
