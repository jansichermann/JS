#import "JSTableViewSectionModel.h"
#import "NSArray+JS.h"
#import "UIView+JS.h"



@interface JSTableViewSectionModel ()

@property (nonatomic)       NSArray                 *rows;
@property (nonatomic)       UIView                  *sectionHeaderView;
@property (nonatomic)       NSAttributedString      *headerAttributedString;
@property (nonatomic)       UIColor                 *headerBackgroundColor;
@property (nonatomic)       CGFloat                 headerTopBottomPadding;
@property (nonatomic)       BOOL                    highlightEntireSection;
@end



@implementation JSTableViewSectionModel


#pragma mark - Initializers

+ (instancetype)sectionWithRows:(NSArray *)rows {
    if (!rows.count > 0) {
        return nil;
    }
    
    JSTableViewSectionModel *m = [[JSTableViewSectionModel alloc] init];
    m.rows = rows;
    return m;
}




#pragma mark - Public Methods

#pragma mark Section Header
- (CGFloat)sectionHeaderHeight {
    if (_sectionHeaderView) {
        return self.sectionHeaderView.height;
    }
    if (!self.headerAttributedString) {
        return 0.f;
    }
    return 2 * self.headerTopBottomPadding + [self.headerAttributedString boundingRectWithSize:
            CGSizeMake([self _sectionHeaderLabelWidth],
                       CGFLOAT_MAX)
                                                     options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                                     context:nil].size.height;
}

- (CGFloat)_sectionHeaderLabelWidth {
    return [UIScreen mainScreen].bounds.size.width - 10.f;
}

- (void)setHeaderView:(UIView *)v {
    self.sectionHeaderView = v;
}

- (void)setSectionHeaderViewWithAttributedTitle:(NSAttributedString *)title
                               topBottomPadding:(CGFloat)padding
                                backgroundColor:(UIColor *)color {
    self.headerAttributedString = title;
    self.headerBackgroundColor = color;
    self.headerTopBottomPadding = padding;
    self.sectionHeaderView = nil;
}

- (UIView *)sectionHeaderView {
    if (!_sectionHeaderView) {
        if (!self.headerAttributedString) {
            return nil;
        }
        CGFloat labelWidth = [self _sectionHeaderLabelWidth];
        CGFloat labelHeight = [self sectionHeaderHeight];
        
        UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                     CGRectMake(0.f,
                                                0.f,
                                                [UIScreen mainScreen].bounds.size.width,
                                                labelHeight)];
        sectionHeaderView.backgroundColor = self.headerBackgroundColor;
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


#pragma mark - Protocol Functions

- (void)insertRowAtTop:(NSObject <JSTableViewRowModelProtocol> *)row {
    NSParameterAssert(row);
    self.rows = [@[row] arrayByAddingObjectsFromArray:self.rows];
}

- (void)addRow:(NSObject <JSTableViewRowModelProtocol> *)row {
    NSParameterAssert(row);
    self.rows = self.rows ? [self.rows arrayByAddingObject:row] : @[row];
}

- (NSObject <JSTableViewRowModelProtocol> *)modelAtRow:(NSUInteger)row {
    return [self.rows objectAtIndexOrNil:row];
}

- (NSInteger)count {
    return (NSInteger)self.rows.count;
}

@end
