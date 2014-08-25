#import "JSTableViewController.h"
#import "NSArray+JS.h"
#import "UIView+JS.h"



@interface JSTableViewController ()
<
UITableViewDelegate,
UITableViewDataSource,
UISearchDisplayDelegate
>
@property (nonatomic, readwrite)        UITableView         *tableView;
@property (nonatomic)                   NSArray             *sections;
@property (nonatomic)                   NSArray             *searchSections;
@property (nonatomic)                   UIView              *pullToRefreshView;
@property (nonatomic)                   UISearchDisplayController *jsSearchDisplayController;
@property (nonatomic, copy)             OnSearchBlock       onSearchBlock;
@end



@implementation JSTableViewController

@synthesize tableView = _tableView;
@synthesize sections = _sections;


- (void)dealloc {
    self.tableView.delegate = nil;
}

#pragma mark - Setup

- (void)loadView {
    UIView *v = [[UIView alloc] init];
    v.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self setupTableViewInView:v tableViewStyle:UITableViewStylePlain];
    self.view = v;
}

- (void)setupTableViewInView:(UIView *)v
              tableViewStyle:(UITableViewStyle)tableViewStyle {
    [self.tableView removeFromSuperview];
    self.tableView = nil;
    UITableView *tableView = [[UITableView alloc] initWithFrame:v.bounds style:tableViewStyle];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    [v insertSubview:tableView atIndex:0];
    self.tableView = tableView;
    [tableView reloadData];
}

- (void)setTableViewStyle:(UITableViewStyle)style {
    [self setupTableViewInView:self.view
                tableViewStyle:style];
}


#pragma mark - TableView Sections

- (void)resetSections {
    self.sections = nil;
}

- (void)resetSearchSections {
    self.searchSections = nil;
}

- (void)setSection:(NSObject <JSTableViewSectionModelProtocol> *)section
           atIndex:(NSUInteger)index {
    NSParameterAssert(self.sections);
    NSParameterAssert(self.sections.count + 1 >= index);
    NSParameterAssert(section);
    NSMutableArray *sections = [NSMutableArray arrayWithArray:self.sections];
    sections[index] = section;
    self.sections = sections.copy;
}

- (void)addSection:(NSObject <JSTableViewSectionModelProtocol> *)section {
    [self addSection:section
     reloadTableView:NO];
}

- (void)updateSection:(NSUInteger)section
             withRows:(NSObject <JSTableViewSectionModelProtocol> *)rows
      reloadTableView:(BOOL)reloadTableView {
    NSMutableArray *sections = [NSMutableArray arrayWithArray:self.sections];
    sections[section] = rows;
    self.sections = sections.copy;
    if (reloadTableView) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)addSection:(NSObject <JSTableViewSectionModelProtocol> *)section
   reloadTableView:(BOOL)reload {
    if (!section) {
        return;
    }
    NSParameterAssert([section conformsToProtocol:@protocol(JSTableViewSectionModelProtocol)]);
    self.sections = self.sections ? [self.sections arrayByAddingObject:section] : @[section];
    if (reload) {
        [self.tableView reloadData];
    }
}

- (void)addSearchSection:(NSObject <JSTableViewSectionModelProtocol> *)section {
    if (!section) {
        return;
    }
    NSParameterAssert([section conformsToProtocol:@protocol(JSTableViewSectionModelProtocol)]);
    self.searchSections = self.searchSections ? [self.searchSections arrayByAddingObject:section] : @[section];
}


#pragma mark - JSTableViewController Convenience

- (NSObject <JSTableViewSectionModelProtocol> *)_sectionModelForTableView:(UITableView *)tableView
                                                                inSection:(NSUInteger)section {
    if (tableView == self.jsSearchDisplayController.searchResultsTableView) {
        return [self.searchSections objectAtIndexOrNil:section];
    }
    return [self.sections objectAtIndexOrNil:section];
}

- (NSObject <JSTableViewRowModelProtocol> *)modelForTableView:(UITableView *)tableView
                                                  atIndexPath:(NSIndexPath *)indexPath {
    
    NSObject <JSTableViewSectionModelProtocol> *rows =
    [self _sectionModelForTableView:tableView
                          inSection:(NSUInteger)indexPath.section];
    
    return [rows modelAtRow:(NSUInteger)indexPath.row];
}

- (UITableViewCell <JSTableViewCellProtocol> *)tableView:(UITableView *)tableView
                                         cellForRowModel:(NSObject <JSTableViewRowModelProtocol> *)rowModel {
    NSParameterAssert([rowModel
                       conformsToProtocol:@protocol(JSTableViewRowModelProtocol)]);
    NSParameterAssert([rowModel.cellClass
                       conformsToProtocol:@protocol(JSTableViewCellProtocol)]);
    
    NSString *cellIdentifier = NSStringFromClass(rowModel.cellClass);
    UITableViewCell <JSTableViewCellProtocol> *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        UITableViewCellStyle s = [rowModel respondsToSelector:@selector(cellStyle)] ?
        rowModel.cellStyle :
        UITableViewCellStyleDefault;
        cell = [[rowModel.cellClass alloc] initWithStyle:s
                                         reuseIdentifier:cellIdentifier];
    }
    return cell;
}

- (void)tableView:(__unused UITableView *)tableView
     didSelectRow:(NSObject <JSTableViewRowModelProtocol> *)rowModel
      atIndexPath:(__unused NSIndexPath *)indexPath {
    if ([rowModel respondsToSelector:@selector(onClickBlock)] &&
        rowModel.onClickBlock) {
        rowModel.onClickBlock();
    }
}


#pragma mark - TableView Delegate, DataSource

- (CGFloat)tableView:(UITableView *)tableView
heightForHeaderInSection:(NSInteger)section {
    NSObject <JSTableViewSectionModelProtocol> *sectionModel =
    [self _sectionModelForTableView:tableView
                          inSection:(NSUInteger)section];
    if (!sectionModel) {
        return 0;
    }
    
    NSParameterAssert([sectionModel conformsToProtocol:@protocol(JSTableViewSectionModelProtocol)]);
    if ([sectionModel respondsToSelector:@selector(sectionHeaderHeight)]) {
        return sectionModel.sectionHeaderHeight;
    }
    return 0.f;
}

- (UIView *)tableView:(UITableView *)tableView
viewForHeaderInSection:(NSInteger)section {
    NSObject <JSTableViewSectionModelProtocol> *sectionModel =
    [self _sectionModelForTableView:tableView
                          inSection:(NSUInteger)section];
    NSParameterAssert([sectionModel conformsToProtocol:@protocol(JSTableViewSectionModelProtocol)]);
    if ([sectionModel respondsToSelector:@selector(sectionHeaderView)]) {
        return sectionModel.sectionHeaderView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject <JSTableViewRowModelProtocol> *rowModel =
    [self modelForTableView:tableView atIndexPath:indexPath];

    if (!rowModel) {
        return 0.f;
    }
    
    if ([rowModel respondsToSelector:@selector(hidden)]) {
        if (rowModel.hidden) {
            return 0.f;
        }
    }
    
    return [rowModel.cellClass heightForModel:rowModel.model
                                  inTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [[self _sectionModelForTableView:tableView
                                  inSection:(NSUInteger)section]
            count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return (NSUInteger) (tableView == self.searchTableView ? self.searchSections.count : self.sections.count);
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject <JSTableViewRowModelProtocol> *rowModel =
    [self modelForTableView:tableView
                atIndexPath:indexPath];
    
    UITableViewCell <JSTableViewCellProtocol> *cell = [self tableView:tableView
                                                      cellForRowModel:rowModel];
    
    if ([rowModel respondsToSelector:@selector(selectionStyle)]) {
        cell.selectionStyle = rowModel.selectionStyle;
    }
    
    if ([rowModel respondsToSelector:@selector(cellBackgroundColor)]
        && rowModel.cellBackgroundColor) {
        cell.backgroundColor = rowModel.cellBackgroundColor;
    }
    
    if ([cell respondsToSelector:@selector(setParentTableView:)]) {
        cell.parentTableView = self.tableView;
    }
    
    // this is consciously done after
    // selectionstyle and background color are set
    // to allow overriding by the configure block
    [cell configureWithModel:rowModel.model];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView
canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject <JSTableViewRowModelProtocol> *m = [self modelForTableView:tableView
                                                            atIndexPath:indexPath];
    if ([m respondsToSelector:@selector(editable)]) {
        return m.editable;
    }
    
    return NO;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
           editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject <JSTableViewRowModelProtocol> *m = [self modelForTableView:tableView
                                                            atIndexPath:indexPath];
    if ([m respondsToSelector:@selector(editingStyle)]) {
        return m.editingStyle;
    }
    return UITableViewCellEditingStyleNone;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject <JSTableViewRowModelProtocol> *rowModel =
    [self modelForTableView:tableView
                atIndexPath:indexPath];
    [self tableView:tableView
       didSelectRow:rowModel
        atIndexPath:indexPath];
}

+ (UIView *)pullToRefreshView {
    return nil;
}

- (void)setOnPullToRefreshBlock:(JS__VoidBlock)onPullToRefreshBlock {
    _onPullToRefreshBlock = [onPullToRefreshBlock copy];
    [self.pullToRefreshView removeFromSuperview];
    if (onPullToRefreshBlock) {
        self.pullToRefreshView = [self.class pullToRefreshView];
        [self.tableView addSubview:self.pullToRefreshView];
        self.pullToRefreshView.top = -self.pullToRefreshView.height;
        [self.pullToRefreshView centerHorizontallyInSuperview];
        self.pullToRefreshView.autoresizingMask =
        UIViewAutoresizingFlexibleLeftMargin |
        UIViewAutoresizingFlexibleRightMargin;
    }
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                  willDecelerate:(__unused BOOL)decelerate {
    if (scrollView.contentOffset.y < -75.f) {
        if (self.onPullToRefreshBlock) {
            self.onPullToRefreshBlock();
        }
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat y = scrollView.contentOffset.y + 30.f;
    if (self.pullToRefreshView && y < 0) {
        
        CGFloat progress = MAX(y, -45) / -45 * (CGFloat)M_PI;
        
        
        self.pullToRefreshView.transform = CGAffineTransformMakeRotation(progress);
    }
}

- (UISearchBar *)addSearchDisplayController:(OnSearchBlock)onSearchBlock {
    self.onSearchBlock = onSearchBlock;
    UISearchBar *searchBar = [[UISearchBar alloc] init];
    self.jsSearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar
                                                                       contentsController:self];
    self.jsSearchDisplayController.delegate = self;
    self.jsSearchDisplayController.searchResultsDataSource = self;
    self.jsSearchDisplayController.searchResultsDelegate = self;
    return searchBar;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString {
    if (self.onSearchBlock) {
        self.onSearchBlock(searchString);
    }
    return NO;
}

- (void)searchDisplayControllerWillBeginSearch:(UISearchDisplayController *)controller {
//    [self.jsSearchDisplayController.searchResultsTableView reloadData];
}

//- (void) searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller;
//- (void) searchDisplayControllerWillEndSearch:(UISearchDisplayController *)controller;
//- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller;

- (UITableView *)searchTableView {
    return self.jsSearchDisplayController.searchResultsTableView;
}
@end
