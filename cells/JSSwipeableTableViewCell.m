#import "JSSwipeableTableViewCell.h"
#import "UIView+JS.h"



@interface JSSwipeableTableViewCellModel()

@end



@implementation JSSwipeableTableViewCellModel

@synthesize leftColor = _leftColor;
@synthesize rightColor = _rightColor;
@synthesize leftTitle = _leftTitle;
@synthesize rightTitle = _rightTitle;
@synthesize leftImage = _leftImage;
@synthesize rightImage = _rightImage;
@synthesize userInfo = _userInfo;

+ (instancetype)withUserInfo:(NSObject *)userInfo {
    JSSwipeableTableViewCellModel *m = [[JSSwipeableTableViewCellModel alloc] init];
    m.userInfo = userInfo;
    return m;
}

+ (instancetype)withLeftImage:(UIImage *)leftImage
                    leftColor:(UIColor *)leftColor
                   rightImage:(UIImage *)rightImage
                   rightColor:(UIColor *)rightcolor
                    direction:(JSSwipeableTableViewCellSwipeDirection)d
                     userInfo:(NSObject *)userInfo
               triggerHandler:(void(^)(UITableViewCell *cell, JSSwipeableTableViewCellSwipeDirection direction))triggerHandler {
    JSSwipeableTableViewCellModel *m = [JSSwipeableTableViewCellModel withUserInfo:userInfo];
    m.leftImage = leftImage;
    m.leftColor = leftColor;
    m.rightImage = rightImage;
    m.rightColor = rightcolor;
    m.swipeableDirections = d;;
    m.swipeTriggerHandler = triggerHandler;
    return m;
}

+ (instancetype)withLeftTitle:(NSAttributedString *)leftTitle
                    leftColor:(UIColor *)leftColor
                   rightTitle:(NSAttributedString *)rightTitle
                   rightColor:(UIColor *)rightcolor
                    direction:(JSSwipeableTableViewCellSwipeDirection)d
                     userInfo:(NSObject *)userInfo
               triggerHandler:(void(^)(UITableViewCell *cell, JSSwipeableTableViewCellSwipeDirection direction))triggerHandler {
    JSSwipeableTableViewCellModel *m = [JSSwipeableTableViewCellModel withUserInfo:userInfo];
    m.leftTitle = leftTitle;
    m.leftColor = leftColor;
    m.rightTitle = rightTitle;
    m.rightColor = rightcolor;
    m.swipeableDirections = d;;
    m.userInfo = userInfo;
    m.swipeTriggerHandler = triggerHandler;
    return m;
}
@end





@interface JSSwipeableTableViewCell()
<UIGestureRecognizerDelegate>

@property (nonatomic) JSSwipeableTableViewCellModel *swipeConfigurationModel;

@property (nonatomic, readwrite) UIView *swipeView;
@property (nonatomic) UIView *triggerView;
@property (nonatomic) UILabel *leftLabel;
@property (nonatomic) UILabel *rightLabel;
@property (nonatomic) UIImageView *leftImage;
@property (nonatomic) UIImageView *rightImage;
@end



static const CGFloat threshold = 0.25f;
CGFloat JSSwipeableTableViewCellNoOffset = 0.f;
CGFloat JSSwipeableTableViewCellOffsetRight = 1.f;
CGFloat JSSwipeableTableViewCellOffsetLeft = -1.f;



@implementation JSSwipeableTableViewCell

@synthesize swipeView = _swipeView;
@synthesize swipeConfigurationModel = _swipeConfigurationModel;
@synthesize triggerView = _triggerView;
@synthesize leftLabel = _leftLabel;
@synthesize rightLabel = _rightLabel;
@synthesize leftImage = _leftImage;
@synthesize rightImage = _rightImage;


- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style
                reuseIdentifier:reuseIdentifier];
    if (!self) {
        return nil;
    }
    
    self.triggerView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.triggerView];
    
    self.leftImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.leftImage];
    
    self.rightImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.rightImage];
    
    self.leftLabel = [[UILabel alloc] init];
    self.leftLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.leftLabel];
    
    self.rightLabel = [[UILabel alloc] init];
    self.rightLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.rightLabel];
    
    self.swipeView = [[UIView alloc] initWithFrame:self.contentView.bounds];
    self.swipeView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.swipeView];
    
    UIPanGestureRecognizer *pr = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(panSwipeView:)];
    pr.delegate = self;
    [self.swipeView addGestureRecognizer:pr];
    
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.leftLabel.text = @"";
    self.rightLabel.text = @"";
    self.leftLabel.alpha = 1.f;
    self.rightLabel.alpha = 1.f;
    self.leftImage.alpha = 1.f;
    self.rightImage.alpha = 1.f;
    self.rightImage.image = nil;
    self.leftImage.image = nil;
    
    [self setSwipeOffsetPercentage:JSSwipeableTableViewCellNoOffset
                          animated:NO
                        fromSource:nil];
}

- (void)layoutSubviews {
    self.triggerView.frame = self.contentView.bounds;
    self.swipeView.frame = self.contentView.bounds;
    [self layoutLabels];
    
    [super layoutSubviews];
}

- (void)layoutImages {
    if (self.rightImage == nil && self.leftImage == nil) {
        return;
    }
    
    [self.leftImage sizeToFit];
    [self.leftImage centerVerticallyInSuperview];
    
    CGFloat min = self.leftImage.image.size.width;
    CGFloat max = threshold * self.contentView.width;
    
    
    
    self.leftImage.right = MAX(min + ((max - min - (self.leftImage.image.size.width / 2.f)) / 2.f),
                               self.swipeView.left - self.leftImage.image.size.width);
    
    [self.rightImage sizeToFit];
    [self.rightImage centerVerticallyInSuperview];
    
    max =
    self.contentView.width - self.rightImage.image.size.width;
    
    min =
    (JSSwipeableTableViewCellOffsetRight - threshold) * self.contentView.width;
    
    self.rightImage.left = MIN(min + ((max - min + (self.rightImage.image.size.width / 2.f)) / 2.f),
                               self.swipeView.right + self.rightImage.image.size.width);
}

- (void)layoutLabels {
    CGFloat labelWidth = self.contentView.width * threshold;
    
    self.leftLabel.frame = CGRectMake(MAX(0, self.swipeView.left - labelWidth),
                                      0.f,
                                      labelWidth,
                                      self.swipeView.height);
    
    self.rightLabel.frame = CGRectMake(MIN(self.swipeView.right, self.swipeView.width - labelWidth),
                                       0.f,
                                       labelWidth,
                                       self.swipeView.height);
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)pr {
    if ([pr isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        CGPoint point = [(UIPanGestureRecognizer *)pr velocityInView:self];
        return fabs(point.x) > fabs(point.y);
    }
    return NO;
}

- (void)panSwipeView:(UIPanGestureRecognizer *)pr {
    NSParameterAssert([pr isKindOfClass:[UIPanGestureRecognizer class]]);
    
    CGFloat translation = [pr translationInView:self.contentView].x;
    CGFloat offset =
    (translation / self.contentView.width);
    
    if (pr.state == UIGestureRecognizerStateChanged) {
        [self setSwipeOffsetPercentage:offset
                              animated:NO
                            fromSource:pr];
    }
    else if (pr.state == UIGestureRecognizerStateCancelled) {
        [self setSwipeOffsetPercentage:JSSwipeableTableViewCellNoOffset
                              animated:YES
                            fromSource:pr];
    }
    else if (pr.state == UIGestureRecognizerStateEnded) {
        if (offset > threshold || offset < -threshold) {
            [self swipeTriggered:offset];
            [self setSwipeOffsetPercentage:offset < JSSwipeableTableViewCellNoOffset ? JSSwipeableTableViewCellOffsetLeft : JSSwipeableTableViewCellOffsetRight
                                  animated:YES
                                fromSource:pr];
        }
        else {
            [self setSwipeOffsetPercentage:JSSwipeableTableViewCellNoOffset
                                  animated:YES
                                fromSource:pr];
        }
    }
}

- (void)configureWithModel:(JSSwipeableTableViewCellModel *)model {
    NSParameterAssert([model isKindOfClass:[JSSwipeableTableViewCellModel class]]);
    
    [super configureWithModel:model];
    self.swipeConfigurationModel = model;
    
    self.leftLabel.attributedText = model.leftTitle;
    self.rightLabel.attributedText = model.rightTitle;
    self.leftImage.image = model.leftImage;
    self.rightImage.image = model.rightImage;
}

- (void)updateTriggerColor:(CGFloat)offset
                  animated:(BOOL)animated {
    
    UIColor *c = [UIColor clearColor];
    
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
                        animated:(BOOL)animated
                      fromSource:(NSObject *)source {
    
    NSParameterAssert(offset <= JSSwipeableTableViewCellOffsetRight && offset >= JSSwipeableTableViewCellOffsetLeft);
    
    if (offset < JSSwipeableTableViewCellNoOffset &&
        !(self.swipeConfigurationModel.swipeableDirections & JSSwipeableTableViewCellSwipeToLeft)) {
        offset = JSSwipeableTableViewCellNoOffset;
    }
    
    if (offset > JSSwipeableTableViewCellNoOffset &&
        !(self.swipeConfigurationModel.swipeableDirections & JSSwipeableTableViewCellSwipeToRight)) {
        offset = JSSwipeableTableViewCellNoOffset;
    }
    
    [self updateTriggerColor:offset
                    animated:YES]; // intentionally overridden
    
    self.leftLabel.hidden = offset < JSSwipeableTableViewCellNoOffset;
    self.rightLabel.hidden = offset > JSSwipeableTableViewCellNoOffset;
    self.leftImage.hidden = offset < JSSwipeableTableViewCellNoOffset;
    self.rightImage.hidden = offset > JSSwipeableTableViewCellNoOffset;
    
    CGRect r = CGRectMake(offset * self.contentView.width,
                          0.f,
                          self.contentView.width,
                          self.contentView.height);
    
    void(^alphaBlock)() = nil;
    if (offset == JSSwipeableTableViewCellOffsetRight || offset == JSSwipeableTableViewCellOffsetLeft) {
        UILabel *l = offset == JSSwipeableTableViewCellOffsetRight ? self.leftLabel : self.rightLabel;
        UIImageView *i = offset == JSSwipeableTableViewCellOffsetRight ? self.leftImage : self.rightImage;
        alphaBlock = ^{
            i.alpha = 0.f;
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
    [self layoutImages];
    
    if ([source isKindOfClass:[UIGestureRecognizer class]]) {
        if (self.swipeConfigurationModel.onSwipeHandler) {
            self.swipeConfigurationModel.onSwipeHandler(self, offset);
        }
    }
}

- (void)swipeTriggered:(CGFloat)offset {
    if (offset < JSSwipeableTableViewCellNoOffset &&
        !(self.swipeConfigurationModel.swipeableDirections & JSSwipeableTableViewCellSwipeToLeft)) {
        return;
    }
    
    if (offset > JSSwipeableTableViewCellNoOffset &&
        !(self.swipeConfigurationModel.swipeableDirections & JSSwipeableTableViewCellSwipeToRight)) {
        return;
    }
    
    JSSwipeableTableViewCellSwipeDirection d = JSSwipeableTableViewCellSwipeNone;
    if (offset > JSSwipeableTableViewCellNoOffset + threshold) {
        d = JSSwipeableTableViewCellSwipeToRight;
    }
    else if (offset < JSSwipeableTableViewCellNoOffset - threshold) {
        d = JSSwipeableTableViewCellSwipeToLeft;
    }
    else {
        return;
    }
    
    if (self.swipeConfigurationModel.swipeTriggerHandler) {
        self.swipeConfigurationModel.swipeTriggerHandler(self, d);
    }
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    self.leftLabel.hidden = highlighted;
    self.rightLabel.hidden = highlighted;
    self.leftImage.hidden = highlighted;
    self.rightImage.hidden = highlighted;
    [super setHighlighted:highlighted
                 animated:animated];
}

- (void)setSelected:(BOOL)selected
           animated:(BOOL)animated {
    self.leftLabel.hidden = selected;
    self.rightLabel.hidden = selected;
    [super setSelected:selected
              animated:animated];
}

@end
