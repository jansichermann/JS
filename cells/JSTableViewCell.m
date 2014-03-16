#import "JSTableViewCell.h"

@implementation JSTableViewCell

+ (CGFloat)heightForModel:(__unused id)model
              inTableView:(__unused UITableView *)tableView {
    return 44.f;
}

- (void)configureWithModel:(id)model {
    if (self.configureBlock) {
        self.configureBlock(model);
    }
}

- (void)prepareForReuse {
    if (self.prepareForReuseBlock) {
        self.prepareForReuseBlock();
    }
}

@end
