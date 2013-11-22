#import "JSSpacingTableViewCell.h"

@implementation JSSpacingTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    return self;
}

+ (CGFloat)heightForModel:(NSNumber *)model
              inTableView:(UITableView *)tableView {
    return model.floatValue;
}

@end
