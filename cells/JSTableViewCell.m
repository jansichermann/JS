#import "JSTableViewCell.h"

@implementation JSTableViewCell

+ (CGFloat)heightForModel:(__unused id)model
              inTableView:(__unused UITableView *)tableView {
    return 44.f;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    
    self.clipsToBounds = YES;
    
    return self;
}

- (void)configureWithModel:(id)model {
    if (self.configureBlock) {
        self.configureBlock(model);
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.layoutSubviewsBlock) {
        self.layoutSubviewsBlock();
    }
}

- (void)prepareForReuse {
    if (self.prepareForReuseBlock) {
        self.prepareForReuseBlock();
    }
}

@end
