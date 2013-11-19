#import "JSTableViewSectionModel.h"
#import "NSArray+JS.h"



@interface JSTableViewSectionModel ()

@property (nonatomic)       NSArray         *rows;

@end



@implementation JSTableViewSectionModel


#pragma mark - Initializers

+ (instancetype)sectionWithRows:(NSArray *)rows {
    NSParameterAssert(rows.count > 0);
    JSTableViewSectionModel *m = [[JSTableViewSectionModel alloc] init];
    m.rows = rows;
    return m;
}


#pragma mark - Public Methods

- (void)addRow:(NSObject <JSTableViewRowModelProtocol> *)row {
    NSParameterAssert(row);
    self.rows = self.rows ? [self.rows arrayByAddingObject:row] : @[row];
}

- (NSObject <JSTableViewRowModelProtocol> *)modelAtRow:(NSUInteger)row {
    return [self.rows objectAtIndexOrNil:row];
}

- (NSInteger)count {
    return self.rows.count;
}

@end
