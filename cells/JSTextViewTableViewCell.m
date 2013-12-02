#import "JSTextViewTableViewCell.h"
#include "JSMacros.h"
#import "UIView+JS.h"


@interface JSTextViewTableViewCellModel()

@property (nonatomic, copy) TextViewBlock           onValueChangeBlock;
@property (nonatomic, copy) TextViewBlock           onDidBeginEditingBlock;
@property (nonatomic)       UIImage                 *icon;

@end



@implementation JSTextViewTableViewCellModel

+ (instancetype)withOnValueChangeBlock:(TextViewBlock)block
                onDidBeginEditingBlock:(TextViewBlock)didBeginEditingBlock {
    return [self withOnValueChangeBlock:block
                 onDidBeginEditingBlock:didBeginEditingBlock
                                   icon:nil];
}
+ (instancetype)withOnValueChangeBlock:(TextViewBlock)block
                onDidBeginEditingBlock:(TextViewBlock)didBeginEditingBlock
                                  icon:(UIImage *)icon {
    JSTextViewTableViewCellModel *m = [[JSTextViewTableViewCellModel alloc] init];
    m.onValueChangeBlock = block;
    m.onDidBeginEditingBlock = didBeginEditingBlock;
    m.icon = icon;
    return m;
}

@end



@interface JSTextViewTableViewCell()
<
UITextViewDelegate
>
@property (nonatomic)       JSTextViewTableViewCellModel        *model;
@property (nonatomic)       UITextView                          *textView;
@end

@implementation JSTextViewTableViewCell

+ (CGFloat)heightForModel:(id)model inTableView:(UITableView *)tableView {
    return 96.f;
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.textView = [[UITextView alloc] init];
    self.textView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.textView.delegate = self;
    [self.contentView addSubview:self.textView];
    WEAK(self);
    self.configureBlock = ^(id model) {
        JSTextViewTableViewCellModel *cellModel = (JSTextViewTableViewCellModel *)model;
        weak_self.model = model;
        weak_self.imageView.contentMode = UIViewContentModeTopLeft;
        weak_self.imageView.image = cellModel.icon;
        weak_self.textView.frame =
        CGRectMake(cellModel.icon ? cellModel.icon.size.width + 32.f : 10.f,
                   0.f,
                   cellModel.icon ? weak_self.contentView.width - 32.f - cellModel.icon.size.width : weak_self.contentView.width,
                   weak_self.contentView.height);
    };
    return self;
}

#pragma mark - UITextViewDelegate 

- (void)textViewDidChange:(UITextView *)textView {
    if (self.model && self.model.onValueChangeBlock) {
        self.model.onValueChangeBlock(textView);
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.model && self.model.onDidBeginEditingBlock) {
        self.model.onDidBeginEditingBlock(textView);
    }
}

@end
