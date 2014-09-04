#import "JSSpacingTableViewCell.h"



@implementation JSSpacingTableViewCell

+ (CGFloat)heightForModel:(NSNumber *)model
              inTableView:(__unused UITableView *)tableView {
    return model.floatValue;
}

@end
