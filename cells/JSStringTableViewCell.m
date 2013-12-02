#import "JSStringTableViewCell.h"

#include "JSMacros.h"

#import "UIView+JS.h"


@interface JSStringTableViewCell ()
@end


@implementation JSStringTableViewCell


#pragma mark - Height

+ (CGFloat)heightForModel:(NSString *)model
              inTableView:(UITableView *)tableView {
    NSParameterAssert(model);
    return [[[NSAttributedString alloc] initWithString:model
                                    attributes:@{
              NSFontAttributeName :[self font]
              }] boundingRectWithSize:CGSizeMake(tableView.width - 32.f, CGFLOAT_MAX)
     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) context:nil].size.height;
}


+ (UIFont *)font {
    return [UIFont systemFontOfSize:14];
}

#pragma - mark Initializer

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.textLabel.numberOfLines = NSIntegerMax;
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.font = [self.class font];
    
    WEAK(self);
    self.configureBlock = ^(id model) {
        JSAssert(weak_self, [model isKindOfClass:[NSString class]], @"Expected NSString");
        weak_self.textLabel.text = model;
        [weak_self.textLabel sizeToFit];
    };
    return self;
}

@end
