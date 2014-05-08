#import "JSViewController.h"



/**
 Created by jan on 11/17/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */
@protocol JSTableViewRowModelProtocol;



typedef void(^OnClickBlock)();



@protocol JSTableViewCellProtocol <NSObject>

@required
+ (CGFloat)heightForModel:(id)model
              inTableView:(UITableView *)tableView;
- (void)configureWithModel:(id)model;

@optional
- (void)setParentTableView:(__weak UITableView *)tableView;

@end



@protocol JSTableViewRowModelProtocol <NSObject>

@required
- (id)model;
- (Class)cellClass;

@optional
- (OnClickBlock)onClickBlock;
- (UIColor *)cellBackgroundColor;
- (UITableViewCellSelectionStyle)selectionStyle;
- (UITableViewCellStyle)cellStyle;
- (UITableViewCellEditingStyle)editingStyle;
- (BOOL)editable;
@end



@protocol JSTableViewSectionModelProtocol <NSObject>

@required
- (NSObject <JSTableViewRowModelProtocol> *)modelAtRow:(NSUInteger)row;
- (NSInteger)count;

@optional
- (UIView *)sectionHeaderView;
- (CGFloat)sectionHeaderHeight;

@end



@interface JSTableViewController : JSViewController
/**
 @discussion The UITableView instance for this controller. This instance may change during the lifetime of this controller, such as when you call setTableViewStyle:
 */
@property (nonatomic, readonly)       UITableView         *tableView;

- (void)setTableViewStyle:(UITableViewStyle)style;

- (void)resetSections;
- (void)setSection:(NSObject <JSTableViewSectionModelProtocol> *)section
           atIndex:(NSUInteger)index;
- (void)addSection:(NSObject <JSTableViewSectionModelProtocol> *)section;
- (void)updateSection:(NSUInteger)section
             withRows:(NSObject <JSTableViewSectionModelProtocol> *)rows
      reloadTableView:(BOOL)reloadTableView;
- (void)addSection:(NSObject <JSTableViewSectionModelProtocol> *)section
   reloadTableView:(BOOL)reload;

@end
