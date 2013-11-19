#import "JSStringTableViewCell.h"
#import "UIView+JS.h"



@implementation JSStringTableViewCell

+ (NSAttributedString *)defaultAttributedStringForString:(NSString *)string {
    NSMutableParagraphStyle *s = [[NSMutableParagraphStyle alloc] init];
    s.lineBreakMode = NSLineBreakByWordWrapping;
    return [[NSAttributedString alloc] initWithString:string
                                           attributes:
            @{
              NSForegroundColorAttributeName: [UIColor darkGrayColor],
              NSFontAttributeName : [UIFont systemFontOfSize:14.f],
              NSParagraphStyleAttributeName : s
              }];
}

+ (CGFloat)heightForModel:(NSString *)model
              inTableView:(UITableView *)tableView {
    NSParameterAssert(model);
    return [[self defaultAttributedStringForString:model]
            boundingRectWithSize:CGSizeMake(tableView.width, INT32_MAX)
            options:0
            context:nil].size.height;
}

- (void)configureWithModel:(NSString *)model {
    self.textLabel.attributedText = [self.class defaultAttributedStringForString:model];
}

@end
