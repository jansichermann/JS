#import "JSTextFieldTableViewCell.h"



@interface JSTextFieldTableViewCellModel ()

@property (nonatomic, copy) OnResignBlock       onResignBlock;

@end



@implementation JSTextFieldTableViewCellModel

+ (instancetype)withOnResignBlock:(OnResignBlock)onResignBlock {
    JSTextFieldTableViewCellModel *m = [[JSTextFieldTableViewCellModel alloc] init];
    m.onResignBlock = onResignBlock;
    return m;
}

@end



@interface JSTextFieldTableViewCell ()

@property (nonatomic)       UITextField                     *textField;
@property (nonatomic)       JSTextFieldTableViewCellModel   *model;

@end



@implementation JSTextFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.textField = [[UITextField alloc] initWithFrame:self.contentView.bounds];
    [self.textField addTarget:self
                       action:@selector(textFieldDoneTapped)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    [self.contentView addSubview:self.textField];
    
    return self;
}

- (void)configureWithModel:(JSTextFieldTableViewCellModel *)model {
    self.model = model;
}

- (void)textFieldDoneTapped {
    if (self.model && self.model.onResignBlock) {
        self.model.onResignBlock(self.textField);
    }
}

@end
