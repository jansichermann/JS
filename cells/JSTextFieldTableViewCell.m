#import "JSTextFieldTableViewCell.h"
#include "JSMacros.h"
#import "UIView+JS.h"

@interface JSTextFieldTableViewCellModel ()

@property (nonatomic, copy) ChangeBlock         onResignBlock;
@property (nonatomic, copy) ChangeBlock         onDidEndEditingBlock;
@property (nonatomic, copy) ChangeBlock         onValueChangeBlock;
@property (nonatomic)       UIFont              *font;
@property (nonatomic)       UIImage             *icon;
@property (nonatomic)       NSString            *placeholderText;
@property (nonatomic)       NSString            *initialText;

@end



@implementation JSTextFieldTableViewCellModel

+ (instancetype)withOnDidEndEditingBlock:(ChangeBlock)onDidEndEditingBlock
                        onDidResignBlock:(ChangeBlock)onDidResignBlock
                      onValueChangeBlock:(ChangeBlock)onValueChangeBlock
                                    font:(UIFont *)font
                                    icon:(UIImage *)icon
                         placeholderText:(NSString *)placeholderText
                             initialText:(NSString *)initialText {
    JSTextFieldTableViewCellModel *m = [[JSTextFieldTableViewCellModel alloc] init];
    m.onResignBlock = onDidResignBlock;
    m.onValueChangeBlock = onValueChangeBlock;
    m.onDidEndEditingBlock = onDidEndEditingBlock;
    m.initialText = initialText;
    m.placeholderText = placeholderText;
    m.font = font;
    m.icon = icon;
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
    self.textField = [[UITextField alloc] initWithFrame:CGRectZero];
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
    WEAK(self);
    self.configureBlock = ^(id model) {
        JSAssert(weak_self,
                 [model isKindOfClass:[JSTextFieldTableViewCellModel class]],
                 @"Expected JSTextFieldTableViewCellModel");
        JSTextFieldTableViewCellModel *cellModel = (JSTextFieldTableViewCellModel *)model;
        
        weak_self.imageView.image = cellModel.icon;
        
#warning not deterministically determined x
        weak_self.textField.frame =
        CGRectMake(cellModel.icon ? cellModel.icon.size.width + 32.f : 10.f,
                   0.f,
                   cellModel.icon ?
                   weak_self.contentView.width - cellModel.icon.size.width - 20.f :
                   weak_self.contentView.width - 10.f,
                   weak_self.contentView.height);
        weak_self.textField.text = cellModel.initialText ? cellModel.initialText : @"";
        weak_self.textField.placeholder = cellModel.placeholderText;
        weak_self.textField.font = cellModel.font;
        weak_self.model = model;

        [weak_self.textField setNeedsLayout];
    };
    
    return self;
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
