#import "JSTableViewRowModel.h"



@interface JSTableViewRowModel ()

@property (nonatomic)                   id                  model;
@property (nonatomic)                   Class               cellClass;
@property (nonatomic, copy, readwrite)  OnClickBlock        onClickBlock;

@end



@implementation JSTableViewRowModel

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
                  onClick:(OnClickBlock)onClickBlock {
    JSTableViewRowModel *m = [[JSTableViewRowModel alloc] init];
    m.model = model;
    m.cellClass = cellClass;
    m.onClickBlock = onClickBlock;
    return m;
}

- (void)setCellClass:(Class)cellClass {
    NSParameterAssert([cellClass conformsToProtocol:@protocol(JSTableViewCellProtocol)]);
    NSParameterAssert([cellClass isSubclassOfClass:[UITableViewCell class]]);
    _cellClass = cellClass;
}
@end
