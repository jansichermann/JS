#import "JSSwipeableTableViewCell.h"
#import "UIView+JS.h"



@interface JSSwipeableTableViewCellModel()

@end



@implementation JSSwipeableTableViewCellModel

- (UIColor *)leftColor {
    if (!_leftColor) {
        _leftColor = [UIColor redColor];
    }
    return _leftColor;
}

- (UIColor *)rightColor {
    if (!_rightColor) {
        _rightColor = [UIColor greenColor];
    }
    return _rightColor;
}

@end





@interface JSSwipeableTableViewCell()
@property (nonatomic) JSSwipeableTableViewCellModel *swipeConfigurationModel;

@property (nonatomic) CGFloat swipeOffset;
@property (nonatomic, readwrite) UIView *swipeView;
@property (nonatomic) UIView *triggerView;

@property (nonatomic) UILabel *leftLabel;
@property (nonatomic) UILabel *rightLabel;

@end


static const CGFloat threshold = 0.25f;

@implementation JSSwipeableTableViewCell

+ (CGFloat)heightForModel:(id)model
              inTableView:(UITableView *)tableView {
    return 44.f;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.triggerView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.triggerView];
    self.triggerView.backgroundColor = [UIColor clearColor];
    
    self.leftLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.rightLabel];
    
    self.swipeView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.swipeView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.swipeView];
    
    UIPanGestureRecognizer *pr = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(panSwipeView:)];
    [self.swipeView addGestureRecognizer:pr];
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.leftLabel.text = @"";
    self.rightLabel.text = @"";
    [self setSwipeOffsetPercentage:0.f
                          animated:NO];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.triggerView.frame = self.contentView.bounds;
    [self layoutLabels];
}

- (void)layoutLabels {
    [self.leftLabel sizeToFit];
    [self.leftLabel centerVerticallyInSuperview];
    self.leftLabel.right = MAX(threshold * self.contentView.width, self.swipeView.left - 4.f);
    
    [self.rightLabel sizeToFit];
    [self.rightLabel centerVerticallyInSuperview];
    self.rightLabel.left = MIN((1.f - threshold) * self.contentView.width, self.swipeView.right + 4.f);
}

+ (UIColor *)initialTriggerColor __attribute__((const)) {
    return [UIColor clearColor];
}


- (void)panSwipeView:(UIPanGestureRecognizer *)pr {
    NSParameterAssert([pr isKindOfClass:[UIPanGestureRecognizer class]]);
    
    CGFloat translation = [pr translationInView:self.contentView].x;
    CGFloat offset =
    (translation / self.contentView.width);
    
    if (pr.state == UIGestureRecognizerStateChanged) {
        [self setSwipeOffsetPercentage:offset
                              animated:NO];
    }
    else if (pr.state == UIGestureRecognizerStateCancelled) {
        [self setSwipeOffsetPercentage:0.f
                              animated:YES];
    }
    else if (pr.state == UIGestureRecognizerStateEnded) {
        if (offset > threshold || offset < -threshold) {
            [self swipeTriggered:offset];
            [self setSwipeOffsetPercentage:offset < 0.f ? -1.f : 1.f
                                  animated:YES];
        }
        else {
            [self setSwipeOffsetPercentage:0.f
                                  animated:YES];
        }
    }
}

- (void)configureWithModel:(JSSwipeableTableViewCellModel *)model {
    NSParameterAssert([model isKindOfClass:[JSSwipeableTableViewCellModel class]]);
    self.swipeConfigurationModel = model;
    
    self.leftLabel.attributedText = model.leftTitle;
    self.rightLabel.attributedText = model.rightTitle;
}

- (void)updateTriggerColor:(CGFloat)offset
                  animated:(BOOL)animated {
    UIColor *c = [self.class initialTriggerColor];
    if (offset < -threshold) {
        c = self.swipeConfigurationModel.rightColor;
    }
    else if (offset > threshold) {
        c = self.swipeConfigurationModel.leftColor;
    }
    
    if (!animated) {
        self.triggerView.backgroundColor = c;
    }
    else {
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.triggerView.backgroundColor = c;
                         }];
    }
}

- (void)setSwipeOffsetPercentage:(CGFloat)offset
                        animated:(BOOL)animated {
    NSParameterAssert(offset <= 1.f);
    NSParameterAssert(offset >= -1.f);
    
    if (offset < 0.f &&
        !(self.swipeConfigurationModel.swipeableDirections & JSSwipeableTableViewCellSwipeToLeft)) {
        return;
    }
    
    if (offset > 0.f &&
        !(self.swipeConfigurationModel.swipeableDirections & JSSwipeableTableViewCellSwipeToRight)) {
        return;
    }
    
    [self updateTriggerColor:offset
                    animated:YES]; // intentionally overridden
    
    self.leftLabel.hidden = offset < 0.f;
    self.rightLabel.hidden = offset > 0.f;
    
    CGRect r = CGRectMake(offset * self.contentView.width,
                          0.f,
                          self.contentView.width,
                          self.contentView.height);
    
    void(^alphaBlock)() = nil;
    if (offset == 1.f || offset == -1.f) {
        UILabel *l = offset == 1.f ? self.leftLabel : self.rightLabel;
        alphaBlock = ^{
            l.alpha = 0.f;
        };
    }
    
    void(^execBlock)() = ^{
        self.swipeView.frame = r;
    };
    
    if (animated) {
        [UIView animateWithDuration:0.05
                         animations:execBlock
                         completion:^(BOOL finished) {
                             if (finished) {
                                 [UIView animateWithDuration:0.4
                                                  animations:alphaBlock];
                             }
                         }];
    }
    else {
        execBlock();
        if (alphaBlock) {
            alphaBlock();
        }
    }
    
    [self layoutLabels];
    
    if (self.swipeConfigurationModel.onSwipeHandler) {
        self.swipeConfigurationModel.onSwipeHandler(self, offset);
    }
}

- (void)swipeTriggered:(CGFloat)offset {
    JSSwipeableTableViewCellSwipeDirection d = JSSwipeableTableViewCellSwipeNone;
    if (offset == 1.f) {
        d = JSSwipeableTableViewCellSwipeToRight;
    }
    else if (offset == 0.f) {
        d = JSSwipeableTableViewCellSwipeToLeft;
    }
    else {
        return;
    }
    
    if (self.swipeConfigurationModel.swipeTriggerHandler) {
        self.swipeConfigurationModel.swipeTriggerHandler(self, d);
    }
}

@end
