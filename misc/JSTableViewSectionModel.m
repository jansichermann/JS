#import "JSTableViewSectionModel.h"
#import "NSArray+JS.h"



@interface JSTableViewSectionModel ()

@property (nonatomic)       NSArray                 *rows;
@property (nonatomic)       UIView                  *sectionHeaderView;
@property (nonatomic)       NSAttributedString      *headerAttributedString;

@end



@implementation JSTableViewSectionModel


#pragma mark - Initializers

+ (instancetype)sectionWithRows:(NSArray *)rows {
    NSParameterAssert(rows.count > 0);
    JSTableViewSectionModel *m = [[JSTableViewSectionModel alloc] init];
    m.rows = rows;
    return m;
}




#pragma mark - Public Methods

- (CGFloat)sectionHeaderHeight {
    if (!self.headerAttributedString) {
        return 0.f;
    }
    return [self.headerAttributedString boundingRectWithSize:
            CGSizeMake([self _sectionHeaderLabelWidth],
                       CGFLOAT_MAX)
                                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                     context:nil].size.height;
}

- (CGFloat)_sectionHeaderLabelWidth {
    return [UIScreen mainScreen].bounds.size.width - 10.f;
}

- (void)setSectionHeaderViewWithAttributedTitle:(NSAttributedString *)title {
    self.headerAttributedString = title;
    self.sectionHeaderView = nil;
}


- (UIView *)sectionHeaderView {
    if (!self.headerAttributedString) {
        return nil;
    }
    if (!_sectionHeaderView) {
        CGFloat labelWidth = [self _sectionHeaderLabelWidth];
        CGFloat labelHeight = [self sectionHeaderHeight];
        
        UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                     CGRectMake(0.f,
                                                0.f,
                                                [UIScreen mainScreen].bounds.size.width,
                                                labelHeight)];
        sectionHeaderView.backgroundColor = [UIColor whiteColor];
        sectionHeaderView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        UILabel *label = [[UILabel alloc] initWithFrame:
                          CGRectMake(10.f,
                                     0.f,
                                     labelWidth,
                                     labelHeight)];
        label.attributedText = self.headerAttributedString;
        label.numberOfLines = NSIntegerMax;
        label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [sectionHeaderView addSubview:label];
        self.sectionHeaderView = sectionHeaderView;
    }
    return _sectionHeaderView;
}

- (void)addRow:(NSObject <JSTableViewRowModelProtocol> *)row {
    NSParameterAssert(row);
    self.rows = self.rows ? [self.rows arrayByAddingObject:row] : @[row];
}

- (NSObject <JSTableViewRowModelProtocol> *)modelAtRow:(NSUInteger)row {
    return [self.rows objectAtIndexOrNil:row];
}

- (NSInteger)count {
    return self.rows.count;
}

@end
