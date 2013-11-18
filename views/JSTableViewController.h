#import "JSViewController.h"



/**
 Created by jan on 11/17/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */


@protocol JSTableViewRowModelProtocol <NSObject>
@required
- (id)model;
- (Class)cellClass;
@end


@protocol JSTableViewSectionModelProtocol <NSObject>
@required
- (NSObject <JSTableViewRowModelProtocol>*)modelAtRow:(NSUInteger)row;
@end


@interface JSTableViewController : JSViewController
@property (nonatomic, readonly)       UITableView         *tableView;
@end
