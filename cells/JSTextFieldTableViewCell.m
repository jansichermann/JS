#import "JSTextFieldTableViewCell.h"



@interface JSTextFieldTableViewCellModel ()

@property (nonatomic, copy) OnResignBlock       onResignBlock;
@property (nonatomic)       NSString            *placeholderText;

@end



@implementation JSTextFieldTableViewCellModel

+ (instancetype)withOnResignBlock:(OnResignBlock)onResignBlock
                  placeholderText:(NSString *)placeholderText {
    JSTextFieldTableViewCellModel *m = [[JSTextFieldTableViewCellModel alloc] init];
    m.onResignBlock = onResignBlock;
    m.placeholderText = placeholderText;
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
    self.textField = [[UITextField alloc] initWithFrame:CGRectInset(self.contentView.bounds, 10.f, 2.f)];
    [self.textField addTarget:self
                       action:@selector(textFieldDoneTapped)
             forControlEvents:UIControlEventEditingDidEndOnExit];
    self.textField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:self.textField];
    
    return self;
}

- (void)configureWithModel:(JSTextFieldTableViewCellModel *)model {
    self.model = model;
    self.textField.placeholder = model.placeholderText;
}

- (void)textFieldDoneTapped {
    if (self.model && self.model.onResignBlock) {
        self.model.onResignBlock(self.textField);
    }
}

@end
