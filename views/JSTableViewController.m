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


- (void)loadView {
    UIView *v = [[UIView alloc] init];
    v.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    UITableView *tableView = [[UITableView alloc] init];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [v addSubview:tableView];
    self.tableView = tableView;
    self.view = v;
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

- (UITableViewCell *)tableView:(UITableView *)tableView
               cellForRowModel:(NSObject <JSTableViewRowModelProtocol> *)rowModel {
    if (!rowModel || ![rowModel conformsToProtocol:@protocol(JSTableViewRowModelProtocol)]) {
        return nil;
    }
    
    NSString *cellIdentifier = NSStringFromClass(rowModel.cellClass);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[rowModel.cellClass alloc] init];
    }
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSObject <JSTableViewRowModelProtocol> *rowModel =
    [self modelForTableView:tableView
                atIndexPath:indexPath];
    
    UITableViewCell *cell = [self tableView:tableView
                            cellForRowModel:rowModel];
    
    return cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}


@end
