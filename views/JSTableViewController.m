#import "JSTableViewController.h"
#import "NSArray+JS.h"


@interface JSTableViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (nonatomic, readwrite)        UITableView         *tableView;
@property (nonatomic)                   NSArray             *sections;

@end



@implementation JSTableViewController

@synthesize tableView = _tableView;
@synthesize sections = _sections;

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


#pragma mark - JSTableViewController Convenience

- (NSObject <JSTableViewSectionModelProtocol> *)_sectionModelForTableView:(__unused UITableView *)tableView
                                                                inSection:(NSUInteger)section {
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
    return [rowModel.cellClass heightForModel:rowModel.model
                                  inTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [[self _sectionModelForTableView:tableView
                                  inSection:(NSUInteger)section]
            count];
}

- (NSInteger)numberOfSectionsInTableView:(__unused UITableView *)tableView {
    return (NSInteger)self.sections.count;
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
    if ([rowModel respondsToSelector:@selector(cellBackgroundColor)] &&
        rowModel.cellBackgroundColor) {
        cell.backgroundColor = rowModel.cellBackgroundColor;
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

@end
