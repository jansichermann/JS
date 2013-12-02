#import "JSTableViewCell.h"

@implementation JSTableViewCell

+ (CGFloat)heightForModel:(id)model
              inTableView:(UITableView *)tableView {
    return 44.f;
}

- (void)configureWithModel:(id)model {
    if (self.configureBlock) {
        self.configureBlock(model);
    }
}

@end
