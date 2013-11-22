#import "JSStringTableViewCell.h"
#import "UIView+JS.h"


@interface JSStringTableViewCell ()
@property (nonatomic)           UILabel         *jsTextLabel;
@end
static const CGFloat        labelXInset = 16.f;


@implementation JSStringTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    self.jsTextLabel = [[UILabel alloc] initWithFrame:CGRectInset(self.contentView.bounds,
                                                                  labelXInset, 0.f)];
    self.jsTextLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.jsTextLabel.numberOfLines = 64;
    self.jsTextLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.jsTextLabel];
    self.textLabel.numberOfLines = 64;
    return self;
}

+ (NSDictionary *)defaultAttributes {
    NSMutableParagraphStyle *s = [[NSMutableParagraphStyle alloc] init];
    s.lineBreakMode = NSLineBreakByWordWrapping;
    return @{
      NSForegroundColorAttributeName: [UIColor darkGrayColor],
      NSFontAttributeName : [UIFont systemFontOfSize:14.f],
      NSParagraphStyleAttributeName : s
      };
}

+ (NSAttributedString *)defaultAttributedStringForString:(NSString *)string {
    if (!string) {
        return nil;
    }
    return [[NSAttributedString alloc] initWithString:string
                                           attributes:
            [self defaultAttributes]];
}

+ (CGFloat)heightForModel:(NSString *)model
              inTableView:(UITableView *)tableView {
    NSParameterAssert(model);
    UILabel *l = [[UILabel alloc] initWithFrame:CGRectInset(tableView.bounds, labelXInset, 0.f)];
    l.attributedText = [self defaultAttributedStringForString:model];
    l.numberOfLines = 96;
    return [l sizeThatFits:l.bounds.size].height;
}

- (void)configureWithModel:(NSString *)model {
    self.jsTextLabel.attributedText = [self.class defaultAttributedStringForString:model];
}

@end
