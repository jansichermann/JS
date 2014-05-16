#import "JSTextFieldTableViewCell.h"
#include "JSMacros.h"
#import "UIView+JS.h"



@interface JSTextFieldTableViewCellModel ()

@property (nonatomic, copy) JSTextFieldDelegateBlock         onEditingDidEndOnExitBlock;
@property (nonatomic, copy) JSTextFieldDelegateBlock         onDidEndEditingBlock;
@property (nonatomic, copy) JSTextFieldDelegateBlock         onValueChangeBlock;
@property (nonatomic)       UIFont              *font;
@property (nonatomic)       UIImage             *icon;
@property (nonatomic)       NSAttributedString  *titleString;
@property (nonatomic)       NSString            *placeholderText;
@property (nonatomic)       NSString            *initialText;
@property (nonatomic)       UIColor             *color;
@property (nonatomic)       BOOL                secureTextEntry;
@property (nonatomic)       UIKeyboardType      keyboardType;
@property (nonatomic)       UITextAutocapitalizationType autoCapitalizationType;

@end



@implementation JSTextFieldTableViewCellModel

+ (instancetype)withOnDidEndEditingBlock:(JSTextFieldDelegateBlock)onDidEndEditingBlock
              onEditingDidEndOnExitBlock:(JSTextFieldDelegateBlock)onEditingDidEndOnExitBlock
                      onValueChangeBlock:(JSTextFieldDelegateBlock)onValueChangeBlock
                                    font:(UIFont *)font
                                    icon:(UIImage *)icon
                                   title:(NSAttributedString *)title
                         placeholderText:(NSString *)placeholderText
                             initialText:(NSString *)initialText
                               textColor:(UIColor *)color
                         secureTextEntry:(BOOL)secureTextEntry
                            keyboardType:(UIKeyboardType)keyboardType
                  autoCapitalizationType:(UITextAutocapitalizationType)autocapitalizationType {
    
    JSTextFieldTableViewCellModel *m = [[JSTextFieldTableViewCellModel alloc] init];
    m.onDidEndEditingBlock = onDidEndEditingBlock;
    m.onValueChangeBlock = onValueChangeBlock;
    m.onEditingDidEndOnExitBlock = onEditingDidEndOnExitBlock;
    m.initialText = initialText;
    m.placeholderText = placeholderText;
    m.font = font;
    // can only set icon or title
    NSParameterAssert(icon == nil || title == nil);
    m.icon = icon;
    m.titleString = title;
    m.color = color;
    m.secureTextEntry = secureTextEntry;
    m.keyboardType = keyboardType;
    m.autoCapitalizationType = autocapitalizationType;
    
    return m;
    
}

@end



@interface JSTextFieldTableViewCell ()

@property (nonatomic)               UILabel             *placeholderLabel;

@end



static const CGFloat cellDefaultHeight = 44.f;



@implementation JSTextFieldTableViewCell



+ (CGFloat)heightForModel:(__unused id)model
              inTableView:(__unused UITableView *)tableView __attribute__((const)) {
    return cellDefaultHeight;
}

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
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.f,
                                                                    0.f,
                                                                    0.f,
                                                                    cellDefaultHeight)];
    [self.contentView addSubview:titleLabel];
    
    WEAK(self);
    self.configureBlock = ^(JSTextFieldTableViewCellModel *model) {
        JSTextFieldTableViewCell *strongSelf = weak_self;
        
        textField.secureTextEntry = model.secureTextEntry;
        textField.autocapitalizationType = model.autoCapitalizationType;
        textField.keyboardType = model.keyboardType;
        textField.onDidEndEditingBlock = model.onDidEndEditingBlock;
        textField.onEditingDidEndOnExitBlock = model.onEditingDidEndOnExitBlock;
        textField.onValueChangeBlock = ^(JSTextField *tf) {
            if (model.onValueChangeBlock) {
                model.onValueChangeBlock(tf);
            }
            strongSelf.placeholderLabel.text = tf.text.length > 0 ? nil : model.placeholderText;
        };
        
        titleLabel.hidden = !model.titleString.length > 0;
        titleLabel.attributedText = model.titleString;
        CGSize s = [titleLabel sizeThatFits:CGSizeMake(150.f, cellDefaultHeight)];
        titleLabel.width = s.width;
        
        CGFloat titleLeft = 10.f;
        if (model.titleString.length > 0) {
            titleLeft = titleLabel.right + 10.f;
        }
        else if (model.icon) {
            titleLeft = model.icon.size.width + 30.f;
        }
        
        strongSelf.imageView.image = model.icon;
        
#warning fix how x is determined
        strongSelf.placeholderLabel.frame =
        CGRectMake(titleLeft,
                   0.f,
                   strongSelf.contentView.width - 10.f - titleLeft,
                   cellDefaultHeight);

        strongSelf.placeholderLabel.font = model.font;
        strongSelf.placeholderLabel.textColor = model.color;
        
        textField.frame = strongSelf.placeholderLabel.frame;
        textField.text = model.initialText ? model.initialText : @"";
        strongSelf.placeholderLabel.text = textField.text.length > 0 ? @"" : model.placeholderText;
        textField.textColor = model.color;
        
        textField.font = model.font;
    };
    
    return self;
    
}

@end
