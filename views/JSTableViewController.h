#import "JSViewController.h"


/**
 Created by jan on 11/17/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
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



@protocol JSTableViewRowModelProtocol;



typedef void(^OnClickBlock)();
typedef void(^OnSearchBlock)(NSString *);


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
- (BOOL)hidden;
@end



@protocol JSTableViewSectionModelProtocol <NSObject>

@required
- (NSObject <JSTableViewRowModelProtocol> *)modelAtRow:(NSUInteger)row;
- (NSInteger)count;

@optional
- (UIView *)sectionHeaderView;
- (CGFloat)sectionHeaderHeight;
- (BOOL)highlightEntireSection;

@end



@interface JSTableViewController : JSViewController
/**
 @discussion The UITableView instance for this controller. This instance may change during the lifetime of this controller, such as when you call setTableViewStyle:
 */
@property (nonatomic, readonly)       UITableView         *tableView;

- (void)setTableViewStyle:(UITableViewStyle)style;


/**
 * --------------
 * Sections
 * --------------
 */

- (void)resetSections;
- (void)resetSearchSections;


- (void)addSection:(NSObject <JSTableViewSectionModelProtocol> *)section;
- (void)addSearchSection:(NSObject <JSTableViewSectionModelProtocol> *)section;


- (void)setSection:(NSObject <JSTableViewSectionModelProtocol> *)section
           atIndex:(NSUInteger)index;

- (void)updateSection:(NSUInteger)section
             withRows:(NSObject <JSTableViewSectionModelProtocol> *)rows
      reloadTableView:(BOOL)reloadTableView;
- (void)addSection:(NSObject <JSTableViewSectionModelProtocol> *)section
   reloadTableView:(BOOL)reload;

/**
 * --------------
 * Selection
 * --------------
 */
- (void)deselectTableView:(UITableView *)tableView
                 animated:(BOOL)animated;


/**
 * --------------
 * Pull to refresh
 * --------------
 */

/**
 @discussion Can be overridden for custom UIView to be used as the arrow
 */
+ (UIView *)pullToRefreshView;

/**
 @discussion Setting this causes a refresh view to be added the tableView
 */
@property (nonatomic, copy) void(^onPullToRefreshBlock)();


/**
 * --------------
 * UISearchDisplayController
 * --------------
 */
- (UISearchBar *)addSearchDisplayController:(OnSearchBlock)onSearchBlock;
- (UITableView *)searchTableView;

@end
