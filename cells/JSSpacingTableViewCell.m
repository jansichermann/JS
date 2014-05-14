#import "JSSpacingTableViewCell.h"
#include "JSMacros.h"



@implementation JSSpacingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    WEAK(self);
    
    self.configureBlock = ^(__unused id model) {
        JSSpacingTableViewCell *strongSelf = weak_self;
        strongSelf.selectionStyle = UITableViewCellSelectionStyleNone;
    };
    return self;
}

+ (CGFloat)heightForModel:(NSNumber *)model
              inTableView:(__unused UITableView *)tableView {
    return model.floatValue;
}

@end
