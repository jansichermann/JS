#import "JSSpacingTableViewCell.h"

@implementation JSSpacingTableViewCell

+ (CGFloat)heightForModel:(NSNumber *)model
              inTableView:(UITableView *)tableView {
    return model.floatValue;
}

@end
