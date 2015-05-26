#import "JSTableViewRowModel.h"



@interface JSTableViewRowModel ()

@property (nonatomic)                   id                  model;
@property (nonatomic)                   Class               cellClass;
@property (nonatomic)                   UIColor             *cellBackgroundColor;
@property (nonatomic)                   UITableViewCellSelectionStyle selectionStyle;
@property (nonatomic)                   UITableViewCellEditingStyle editingStyle;
@end



@implementation JSTableViewRowModel

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass {
    return [self withModel:model
                 cellClass:cellClass
                   onClick:nil];
}

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
           selectionStyle:(UITableViewCellSelectionStyle)style {
    return [self withModel:model
                 cellClass:cellClass
            backgroundColor:nil
            selectionStyle:style];
}


+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
          backgroundColor:(UIColor *)bgColor
selectionStyle:(UITableViewCellSelectionStyle)style {
    return [self withModel:model
                 cellClass:cellClass
           backgroundColor:bgColor
                   selectionStyle:style
                   onClick:nil];
}

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
          backgroundColor:(UIColor *)bgColor {
    return [self withModel:model
                 cellClass:cellClass
           backgroundColor:bgColor
                   onClick:nil];
}

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
                  onClick:(OnClickBlock)onClickBlock {
    return [self withModel:model
                 cellClass:cellClass
           backgroundColor:nil
                   onClick:onClickBlock];
}

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
          backgroundColor:(UIColor *)bgColor
                  onClick:(OnClickBlock)onClickBlock {
    return [self withModel:model
                 cellClass:cellClass
           backgroundColor:bgColor
            selectionStyle:UITableViewCellSelectionStyleGray
                   onClick:onClickBlock];
}

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
          backgroundColor:(UIColor *)bgColor
           selectionStyle:(UITableViewCellSelectionStyle)style
                  onClick:(OnClickBlock)onClickBlock {
    return [self withModel:model
                 cellClass:cellClass
            backgroundColor:bgColor
            selectionStyle:style
            editingStyle:UITableViewCellEditingStyleNone
                   onClick:onClickBlock];
}

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
          backgroundColor:(UIColor *)bgColor
           selectionStyle:(UITableViewCellSelectionStyle)style
             editingStyle:(UITableViewCellEditingStyle)editingStyle
                  onClick:(OnClickBlock)onClickBlock {
    return [self withModel:model
                 cellClass:cellClass
           backgroundColor:bgColor
            selectionStyle:style
             accessoryType:UITableViewCellAccessoryNone
              editingStyle:editingStyle
                   onClick:onClickBlock];
}

+ (instancetype)withModel:(id)model
                cellClass:(Class)cellClass
          backgroundColor:(UIColor *)bgColor
           selectionStyle:(UITableViewCellSelectionStyle)style
            accessoryType:(UITableViewCellAccessoryType)accessoryType
             editingStyle:(UITableViewCellEditingStyle)editingStyle
                  onClick:(OnClickBlock)onClickBlock {
    JSTableViewRowModel *m = [[JSTableViewRowModel alloc] init];
    m.model = model;
    m.cellClass = cellClass;
    m.onClickBlock = onClickBlock;
    m.cellBackgroundColor = bgColor;
    m.selectionStyle = style;
    m.editingStyle = editingStyle;
    m.accessoryType = accessoryType;
    return m;
}

- (void)setCellClass:(Class)cellClass {
    NSParameterAssert([cellClass conformsToProtocol:@protocol(JSTableViewCellProtocol)]);
    NSParameterAssert([cellClass isSubclassOfClass:[UITableViewCell class]]);
    _cellClass = cellClass;
}

- (BOOL)editable {
    return self.editingStyle != UITableViewCellEditingStyleNone;
}

@end
