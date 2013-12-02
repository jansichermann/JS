#import "JSSpacingTableViewCell.h"
#include "JSMacros.h"



@implementation JSSpacingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    WEAK(self);
    self.configureBlock = ^(__unused id model) {
        weak_self.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    return self;
}

+ (CGFloat)heightForModel:(NSNumber *)model
              inTableView:(UITableView *)tableView {
    return model.floatValue;
}

@end
