#import "JSViewController.h"



/**
 Created by jan on 11/17/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */
@protocol JSTableViewRowModelProtocol;

typedef void(^OnClickBlock)(NSObject <JSTableViewRowModelProtocol> *rowModel,
                            NSIndexPath *indexPath);


@protocol JSTableViewCellProtocol <NSObject>

@required
+ (id)alloc;
+ (CGFloat)heightForModel:(id)model
              inTableView:(UITableView *)tableView;
- (void)configureWithModel:(id)model;

@end



@protocol JSTableViewRowModelProtocol <NSObject>

@required
- (id)model;
- (Class <JSTableViewCellProtocol>)cellClass;

@optional
@property (nonatomic, copy, readonly)   OnClickBlock        onClickBlock;
- (UITableViewCellStyle)cellStyle;

@end



@protocol JSTableViewSectionModelProtocol <NSObject>

@required
- (NSObject <JSTableViewRowModelProtocol> *)modelAtRow:(NSUInteger)row;
- (void)addRow:(NSObject <JSTableViewRowModelProtocol> *)row;
- (NSInteger)count;

@end



@interface JSTableViewController : JSViewController
@property (nonatomic, readonly)       UITableView         *tableView;

- (void)setTableViewStyle:(UITableViewStyle)style;

- (void)resetSections;
- (void)addSection:(NSObject <JSTableViewSectionModelProtocol> *)section
   reloadTableView:(BOOL)reload;

@end
