#import "JSActionSheetController.h"

#import "JSButton.h"
#import "UIView+JS.h"
#import "UIImage+ImageEffects.h"
#import "NSAttributedString+JS.h"


@interface JSActionSheetItem ()

@property (nonatomic, copy)     OnClickBlock    onClickBlock;
@property (nonatomic)           BOOL isInfoItem;
@property (nonatomic)           NSAttributedString *title;
@property (nonatomic)           UIView *view;

@end



@implementation JSActionSheetItem

+ (instancetype)infoItemWithText:(NSAttributedString *)text {
    JSActionSheetItem *i = [[JSActionSheetItem alloc] init];
    i.isInfoItem = YES;
    i.title = text;
    return i;
};

+ (instancetype)withTitle:(NSString *)title
               titleColor:(UIColor *)color
                titleFont:(UIFont *)titleFont
                  onClick:(OnClickBlock)onClickBlock {
    JSActionSheetItem *i = [[JSActionSheetItem alloc] init];
    i.title = [NSAttributedString withString:title
                                        font:titleFont
                                       color:color];
    i.onClickBlock = onClickBlock;
    return i;
}

+ (instancetype)withView:(UIView *)view
                 onClick:(OnClickBlock)onClickBlock {
    JSActionSheetItem *i = [[JSActionSheetItem alloc] init];
    i.view = view;
    i.onClickBlock = onClickBlock;
    return i;
}

@end



@interface JSActionSheetController ()
@property (nonatomic)           NSArray         *items;
@property (nonatomic)           UIView          *buttonView;
@property (nonatomic)           BOOL            hasCancel;
@end

@implementation JSActionSheetController

static NSString * const cancelTitle = @"Cancel";

- (instancetype)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.shouldBlur = YES;
    return self;
}

+ (instancetype)withItems:(NSArray *)items
   cancelButtonTitleColor:(UIColor *)titleColor
    cancelButtonTitleFont:(UIFont *)titleFont {
    JSActionSheetController *c = [[JSActionSheetController alloc] init];
    if (titleColor && titleFont) {
        c.hasCancel = YES;
        c.items = [items arrayByAddingObject:
                   [JSActionSheetItem withTitle:cancelTitle
                                     titleColor:titleColor
                                      titleFont:titleFont
                                        onClick:nil]
                   ];
    }
    [c layoutForItems];
    return c;
}

- (void)pressDown:(UIButton *)b {
    b.superview.backgroundColor = [UIColor colorWithWhite:0.95f alpha:1.f];
}

- (void)cancelPress:(UIButton *)b {
    b.superview.backgroundColor = [UIColor whiteColor];
}

- (UIView *)labelForItem:(JSActionSheetItem *)item {
    UILabel *l = [[UILabel alloc] init];
    l.numberOfLines = 0;
    l.attributedText = item.title;
    return l;
}

- (UIView *)viewForItem:(JSActionSheetItem *)item {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.width, buttonHeight)];
    v.backgroundColor = [UIColor whiteColor];
    
    if (item.isInfoItem) {
        UIView *label = [self labelForItem:item];
        [v addSubview:label];
        
        CGSize s =
        [label sizeThatFits:CGSizeMake(self.view.width - 40.f,
                                   CGFLOAT_MAX)];
        v.frame = CGRectMake(0.f,
                             0.f,
                             self.view.width,
                             MAX(buttonHeight, s.height + 32.f));
        
        label.frame = CGRectInset(v.bounds, 20.f, 16.f);
    }
    else if (item.view) {
        [v addSubview:item.view];
        v.frame = CGRectMake(0.f,
                             0.f,
                             self.view.width,
                             item.view.height);
        UIView *button = [self buttonForItem:item];
        [v addSubview:button];
        button.frame = v.bounds;
    }
    else {
        UIView *button = [self buttonForItem:item];
        [v addSubview:button];
        v.frame = CGRectMake(0.f,
                             0.f,
                             self.view.width,
                             MAX(buttonHeight, button.height));
        button.frame = v.bounds;
    }
    return v;
}

- (JSButton *)buttonForItem:(JSActionSheetItem *)item {
    
    JSButton *b = [JSButton buttonWithType:UIButtonTypeCustom];
    [b addTarget:self
          action:@selector(pressDown:)
forControlEvents:UIControlEventTouchDown];
    
    [b addTarget:self
          action:@selector(cancelPress:)
forControlEvents:UIControlEventAllEvents ^ UIControlEventTouchDown];
    
    b.autoresizingMask = UIViewAutoresizingFlexibleWidth;

    if (item.title) {
        [b setAttributedTitle:item.title
                     forState:UIControlStateNormal];
    }
    
    [b setTitleColor:((UIWindow *)[UIApplication sharedApplication].windows.lastObject).tintColor
            forState:UIControlStateHighlighted];
    
    // the button explicitly introduces a retain cycle
    // so the controller sticks around
    b.touchUpInsideBlock = ^(__unused JSButton *bb) {
        [self dismiss];
        if (item.onClickBlock) {
            item.onClickBlock();
        }
    };
    return b;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0.f,
                                                               150.f,
                                                               self.view.width,
                                                               44.f)];
    
    self.buttonView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    self.buttonView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.buttonView];
}

static const CGFloat buttonHeight = 44.f;

- (void)_removeButtons {
    for (UIView *v in self.buttonView.subviews) {
        [v removeFromSuperview];
    }
}

- (void)layoutForItems {
    [self _removeButtons];
    
    CGFloat height = 0.f;
    
    for (NSUInteger i = 0; i < self.items.count; i++) {
        JSActionSheetItem *item = self.items[i];
        NSParameterAssert([item isKindOfClass:[JSActionSheetItem class]]);
        
        BOOL isCancel = i == self.items.count - 1 && self.hasCancel;
        
        UIView *v = [self viewForItem:item];
        v.frame = CGRectMake(0.f,
                             height + (isCancel ? 8.f : 0.f),
                             self.view.width,
                             v.height);
        
        [self.buttonView addSubview:v];
        
        height += v.height;
        
        UIView *divider = [[UIView alloc] initWithFrame:
                           CGRectMake(10.f,
                                      v.bottom - 1.f,
                                      v.width - 20.f,
                                      1.f)];
        
        divider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        divider.backgroundColor =
        [UIColor colorWithWhite:0.95f
                          alpha:1.f];
        
        [self.buttonView addSubview:divider];
        self.buttonView.height = v.bottom;
    }
}

- (void)present {
    UIWindow *w = [[UIApplication sharedApplication] windows].firstObject;
    
    UIView *v = nil;
    
    if (self.shouldBlur) {
        UIGraphicsBeginImageContextWithOptions(w.bounds.size,
                                               NO,
                                               w.screen.scale);
        
        [w drawViewHierarchyInRect:w.frame afterScreenUpdates:NO];
        
        UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
        
        UIImage *blurredSnapshotImage =
        [snapshotImage applyBlurWithRadius:4
                                 tintColor:[UIColor colorWithWhite:0.f
                                                             alpha:0.1f]
                     saturationDeltaFactor:1.f
                                 maskImage:nil];
        
        UIGraphicsEndImageContext();
        v = [[UIImageView alloc] initWithImage:blurredSnapshotImage];
        v.tag = 11;
        v.alpha = 0.f;
    }
    else {
        v = [[UIView alloc] initWithFrame:w.bounds];
        v.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.4f];
    }
    v.tag = 11;
    v.alpha = 0.f;
    
    [self.view insertSubview:v belowSubview:self.buttonView];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.view.frame = w.bounds;
    [w addSubview:self.view];
    
    self.buttonView.frame = CGRectMake(0.f,
                                       self.view.height,
                                       self.view.width,
                                       self.buttonView.height);
    [UIView animateWithDuration:0.2
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         v.alpha = 1.f;
                         self.buttonView.top = self.view.height - self.buttonView.height;
                     }
                     completion:nil];
}

- (void)dismiss {
    // we remove buttons and unsetitems because
    // we'd otherwise have a retain cycle introduced by the cancel button;
    UIView *v = [self.view viewWithTag:11];
    [UIView animateWithDuration:0.2f
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         v.alpha = 0.f;
                         self.buttonView.top = self.view.height;
                     }
                     completion:^(BOOL finished) {
                         [self _removeButtons];
                         self.items = nil;
                         [self.view removeFromSuperview];
                     }];
}


@end
