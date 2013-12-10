#import "JSTextFieldTableViewCell.h"
#include "JSMacros.h"
#import "UIView+JS.h"

@interface JSTextFieldTableViewCellModel ()

@property (nonatomic, copy) JSTextFieldDelegateBlock         onEditingDidEndOnExitBlock;
@property (nonatomic, copy) JSTextFieldDelegateBlock         onDidEndEditingBlock;
@property (nonatomic, copy) JSTextFieldDelegateBlock         onValueChangeBlock;
@property (nonatomic)       UIFont              *font;
@property (nonatomic)       UIImage             *icon;
@property (nonatomic)       NSString            *placeholderText;
@property (nonatomic)       NSString            *initialText;
@property (nonatomic)       UIColor             *color;

@end



@implementation JSTextFieldTableViewCellModel

+ (instancetype)withOnDidEndEditingBlock:(JSTextFieldDelegateBlock)onDidEndEditingBlock
              onEditingDidEndOnExitBlock:(JSTextFieldDelegateBlock)onEditingDidEndOnExitBlock
                      onValueChangeBlock:(JSTextFieldDelegateBlock)onValueChangeBlock
                                    font:(UIFont *)font
                                    icon:(UIImage *)icon
                         placeholderText:(NSString *)placeholderText
                             initialText:(NSString *)initialText
                               textColor:(UIColor *)color {
    JSTextFieldTableViewCellModel *m = [[JSTextFieldTableViewCellModel alloc] init];
    m.onDidEndEditingBlock = onDidEndEditingBlock;
    m.onValueChangeBlock = onValueChangeBlock;
    m.onEditingDidEndOnExitBlock = onEditingDidEndOnExitBlock;
    m.initialText = initialText;
    m.placeholderText = placeholderText;
    m.font = font;
    m.icon = icon;
    m.color = color;
    return m;
}

@end



@interface JSTextFieldTableViewCell ()

@property (nonatomic)               UILabel             *placeholderLabel;

@end



@implementation JSTextFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.placeholderLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.placeholderLabel];
    
    JSTextField *textField = [[JSTextField alloc] init];
    [self.contentView addSubview:textField];
    
    WEAK(self);
    self.configureBlock = ^(id model) {
        JSAssert(weak_self,
                 [model isKindOfClass:[JSTextFieldTableViewCellModel class]],
                 @"Expected JSTextFieldTableViewCellModel");
        JSTextFieldTableViewCellModel *cellModel = (JSTextFieldTableViewCellModel *)model;
        
        textField.onDidEndEditingBlock = cellModel.onDidEndEditingBlock;
        textField.onEditingDidEndOnExitBlock = cellModel.onEditingDidEndOnExitBlock;
        textField.onValueChangeBlock = ^(UITextField *tf) {
            cellModel.onValueChangeBlock(tf);
            weak_self.placeholderLabel.text = tf.text.length > 0 ? nil : cellModel.placeholderText;
        };
        
        
        weak_self.imageView.image = cellModel.icon;
        
#warning fix how x is determined
        weak_self.placeholderLabel.frame =
        CGRectMake(cellModel.icon ? cellModel.icon.size.width + 32.f : 10.f,
                   0.f,
                   cellModel.icon ?
                   weak_self.contentView.width - cellModel.icon.size.width - 20.f :
                   weak_self.contentView.width - 10.f,
                   weak_self.contentView.height);

        weak_self.placeholderLabel.font = cellModel.font;
        weak_self.placeholderLabel.textColor = cellModel.color;
        
        textField.frame = weak_self.placeholderLabel.frame;
        textField.text = cellModel.initialText ? cellModel.initialText : @"";
        weak_self.placeholderLabel.text = textField.text.length > 0 ? @"" : cellModel.placeholderText;
        textField.textColor = cellModel.color;
        
        textField.font = cellModel.font;
    };
    
    return self;
}

@end
