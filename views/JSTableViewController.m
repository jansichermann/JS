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

- (void)addSection:(NSObject <JSTableViewSectionModelProtocol> *)section {
    [self addSection:section
     reloadTableView:NO];
}

- (void)updateSection:(NSUInteger)section
             withRows:(NSArray *)rows
      reloadTableView:(BOOL)reloadTableView {
    NSMutableArray *sections = [NSMutableArray arrayWithArray:self.sections];
    sections[section] = rows.copy;
    self.sections = sections.copy;
    if (reloadTableView) {
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section]
                      withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (void)addSection:(NSObject <JSTableViewSectionModelProtocol> *)section
   reloadTableView:(BOOL)reload {
    NSParameterAssert(section);
    NSParameterAssert([section conformsToProtocol:@protocol(JSTableViewSectionModelProtocol)]);
    self.sections = self.sections ? [self.sections arrayByAddingObject:section] : @[section];
    if (reload) {
        [self.tableView reloadData];
    }
}


#pragma mark - TableView Delegate, DataSource

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSObject <JSTableViewRowModelProtocol> *rowModel =
    [self modelForTableView:tableView atIndexPath:indexPath];
    return [rowModel.cellClass heightForModel:rowModel.model
                                  inTableView:tableView];
}

- (NSObject <JSTableViewSectionModelProtocol> *)rowsForTableView:(UITableView *)tableView
                                                       inSection:(NSUInteger)section {
    return [self.sections objectAtIndexOrNil:section];
}

- (NSObject <JSTableViewRowModelProtocol> *)modelForTableView:(UITableView *)tableView
                                                  atIndexPath:(NSIndexPath *)indexPath {
    
    NSObject <JSTableViewSectionModelProtocol> *rows =
    [self rowsForTableView:tableView
                 inSection:indexPath.section];
    
    return [rows modelAtRow:indexPath.row];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self rowsForTableView:tableView
                         inSection:section]
            count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

- (UITableViewCell <JSTableViewCellProtocol> *)tableView:(UITableView *)tableView
                                         cellForRowModel:(NSObject <JSTableViewRowModelProtocol> *)rowModel {
    NSParameterAssert(![rowModel
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

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSObject <JSTableViewRowModelProtocol> *rowModel =
    [self modelForTableView:tableView
                atIndexPath:indexPath];
    
    UITableViewCell <JSTableViewCellProtocol> *cell = [self tableView:tableView
                                                      cellForRowModel:rowModel];
    
    [cell configureWithModel:rowModel.model];
    if ([rowModel respondsToSelector:@selector(cellBackgroundColor)] &&
        rowModel.cellBackgroundColor) {
        cell.contentView.backgroundColor = rowModel.cellBackgroundColor;
        cell.backgroundColor = rowModel.cellBackgroundColor;
    }
    
    return cell;
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

- (void)tableView:(UITableView *)tableView
     didSelectRow:(NSObject <JSTableViewRowModelProtocol> *)rowModel
      atIndexPath:(NSIndexPath *)indexPath {
    if ([rowModel respondsToSelector:@selector(onClickBlock)] &&
        rowModel.onClickBlock) {
        rowModel.onClickBlock();
    }
}


@end
