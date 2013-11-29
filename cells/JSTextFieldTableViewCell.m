#import "JSTextFieldTableViewCell.h"



@interface JSTextFieldTableViewCellModel ()

@property (nonatomic, copy) ChangeBlock         onResignBlock;
@property (nonatomic, copy) ChangeBlock         onDidEndEditingBlock;
@property (nonatomic, copy) ChangeBlock         onValueChangeBlock;
@property (nonatomic)       NSString            *placeholderText;
@property (nonatomic)       NSString            *initialText;

@end



@implementation JSTextFieldTableViewCellModel

+ (instancetype)withOnDidEndEditingBlock:(ChangeBlock)onDidEndEditingBlock
                        onDidResignBlock:(ChangeBlock)onDidResignBlock
                      onValueChangeBlock:(ChangeBlock)onValueChangeBlock
                         placeholderText:(NSString *)placeholderText
                             initialText:(NSString *)initialText {
    JSTextFieldTableViewCellModel *m = [[JSTextFieldTableViewCellModel alloc] init];
    m.onResignBlock = onDidResignBlock;
    m.onValueChangeBlock = onValueChangeBlock;
    m.onDidEndEditingBlock = onDidEndEditingBlock;
    m.initialText = initialText;
    m.placeholderText = placeholderText;
    return m;
}

@end



@interface JSTextFieldTableViewCell ()

@property (nonatomic, readwrite)       UITextField                     *textField;
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
    [self.textField addTarget:self
                       action:@selector(textFieldResigned)
             forControlEvents:UIControlEventEditingDidEnd];
    [self.textField addTarget:self
                       action:@selector(textFieldChanged)
             forControlEvents:UIControlEventEditingChanged];
    self.textField.returnKeyType = UIReturnKeyDone;
    [self.contentView addSubview:self.textField];
    
    return self;
}

- (void)configureWithModel:(JSTextFieldTableViewCellModel *)model {
    self.model = model;
    self.textField.text = model.initialText ? model.initialText : @"";
    self.textField.placeholder = model.placeholderText;
}

- (void)textFieldResigned {
    if (self.model && self.model.onResignBlock) {
        self.model.onResignBlock(self.textField);
    }
}

- (void)textFieldDoneTapped {
    if (self.model && self.model.onDidEndEditingBlock) {
        self.model.onDidEndEditingBlock(self.textField);
    }
}

- (void)textFieldChanged {
    if (self.model && self.model.onValueChangeBlock) {
        self.model.onValueChangeBlock(self.textField);
    }
}

@end
