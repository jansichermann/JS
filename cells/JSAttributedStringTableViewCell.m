#import "JSAttributedStringTableViewCell.h"

#include "JSMacros.h"

#import "UIView+JS.h"



@interface JSAttributedStringTableViewCellModel()
@property (nonatomic)           NSAttributedString          *text;
@property (nonatomic)           CGFloat                     topBottomPadding;
@property (nonatomic)           UIImage                     *icon;
@end



@implementation JSAttributedStringTableViewCellModel

+ (instancetype)withText:(NSAttributedString *)text {
    return [self withText:text topBottomPadding:0];
}

+ (instancetype)withText:(NSAttributedString *)text icon:(UIImage *)icon {
    return [self withText:text icon:icon topBottomPadding:0];
}

+ (instancetype)withText:(NSAttributedString *)text
        topBottomPadding:(CGFloat)topBottomPadding {
    return [self withText:text icon:nil topBottomPadding:topBottomPadding];
}

+ (instancetype)withText:(NSAttributedString *)text
                    icon:(UIImage *)icon
        topBottomPadding:(CGFloat)topBottomPadding {
    JSAttributedStringTableViewCellModel *m = [[JSAttributedStringTableViewCellModel alloc] init];
    m.text = text;
    m.icon = icon;
    m.topBottomPadding = topBottomPadding;
    return m;
}



@end


@implementation JSAttributedStringTableViewCell

+ (CGFloat)heightForModel:(JSAttributedStringTableViewCellModel *)model
              inTableView:(UITableView *)tableView {
    NSParameterAssert([model isKindOfClass:[JSAttributedStringTableViewCellModel class]]);
    NSParameterAssert([model.text isKindOfClass:[NSAttributedString class]]);
    return [model.text boundingRectWithSize:CGSizeMake(tableView.width,
                                                       CGFLOAT_MAX)
                                    options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                    context:nil].size.height + 2 * model.topBottomPadding;
}

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.textLabel.numberOfLines = INT16_MAX;
    UILabel *textLabel = self.textLabel;
    UIImageView *imageView = self.imageView;
    self.configureBlock = ^(id model) {
        JSAttributedStringTableViewCellModel *cellModel = (JSAttributedStringTableViewCellModel *)model;
        textLabel.attributedText = cellModel.text;
        imageView.image = cellModel.icon;
        [textLabel sizeToFit];
    };
    return self;
}

@end
