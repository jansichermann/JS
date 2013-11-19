#import "JSAttributedStringTableViewCell.h"
#import "UIView+JS.h"



@implementation JSAttributedStringTableViewCell

+ (CGFloat)heightForModel:(NSAttributedString *)model
              inTableView:(UITableView *)tableView {
    NSParameterAssert([model isKindOfClass:[NSAttributedString class]]);
    return [model boundingRectWithSize:CGSizeMake(tableView.width,
                                                  INT32_MAX)
                               options:0
                               context:nil].size.height;
}

- (void)configureWithModel:(NSAttributedString *)model {
    NSParameterAssert([model isKindOfClass:[NSAttributedString class]]);
    self.textLabel.attributedText = model;
}

@end
