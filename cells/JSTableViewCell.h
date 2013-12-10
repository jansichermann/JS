#import <UIKit/UIKit.h>
#import "JSTableViewController.h"


typedef void(^ConfigureBlock)(id model);
typedef void(^PrepareForReuseBlock)();


/**
 Created by jan on 11/18/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.\
 */



@interface JSTableViewCell : UITableViewCell
<
JSTableViewCellProtocol
>

@property (nonatomic, copy)         ConfigureBlock          configureBlock;
@property (nonatomic, copy)         PrepareForReuseBlock    prepareForReuseBlock;

+ (CGFloat)heightForModel:(id)model
              inTableView:(UITableView *)tableView;
- (void)configureWithModel:(id)model;


@end
