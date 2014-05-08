#import "JSActionSheetController.h"

#include "JSMacros.h"

#import "JSButton.h"
#import "UIView+JS.h"
#import "UIImage+ImageEffects.h"


@interface JSActionSheetItem ()

@property (nonatomic)           NSString        *title;
@property (nonatomic, copy)     OnClickBlock    onClickBlock;
@property (nonatomic)           UIFont          *titleFont;
@property (nonatomic)           UIColor         *titleColor;

@end

@implementation JSActionSheetItem

+ (instancetype)withTitle:(NSString *)title
               titleColor:(UIColor *)color
                titleFont:(UIFont *)titleFont
                  onClick:(OnClickBlock)onClickBlock {
    JSActionSheetItem *i = [[JSActionSheetItem alloc] init];
    i.title = title;
    i.onClickBlock = onClickBlock;
    i.titleFont = titleFont;
    i.titleColor = color;
    return i;
}

@end



@interface JSActionSheetController ()
@property (nonatomic)           NSArray         *items;
@property (nonatomic)           UIView          *buttonView;
@end

@implementation JSActionSheetController

+ (instancetype)withItems:(NSArray *)items
   cancelButtonTitleColor:(UIColor *)titleColor
    cancelButtonTitleFont:(UIFont *)titleFont {
    JSActionSheetController *c = [[JSActionSheetController alloc] init];
    c.items = [items arrayByAddingObject:
               [JSActionSheetItem withTitle:@"Cancel"
                                 titleColor:titleColor
                                  titleFont:titleFont
                                    onClick:nil]
               ];
    [c layoutForItems];
    return c;
}

- (JSButton *)buttonForItem:(JSActionSheetItem *)item {
    
    JSButton *b = [JSButton buttonWithType:UIButtonTypeCustom];
    
    b.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    b.backgroundColor = [UIColor clearColor];
    
    [b setTitle:item.title
       forState:UIControlStateNormal];
    
    [b setTitleColor:item.titleColor
            forState:UIControlStateNormal];
    
    [b setTitleColor:((UIWindow *)[UIApplication sharedApplication].windows.lastObject).tintColor
            forState:UIControlStateHighlighted];
    
    b.titleLabel.font = item.titleFont;
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
    self.buttonView.backgroundColor = [UIColor whiteColor];
    
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
    for (NSUInteger i = 0; i < self.items.count; i++) {
        JSActionSheetItem *item = self.items[i];
        NSParameterAssert([item isKindOfClass:[JSActionSheetItem class]]);
        
        JSButton *b = [self buttonForItem:item];
        b.frame = CGRectMake(0.f,
                             i * buttonHeight,
                             self.view.width,
                             buttonHeight);
        
        [self.buttonView addSubview:b];
        
        UIView *divider = [[UIView alloc] initWithFrame:CGRectMake(10.f, b.bottom, b.width - 20.f, 1.f)];
        divider.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        divider.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.f];
        [self.buttonView addSubview:divider];
    }
}

- (void)present {
    UIWindow *w = [[UIApplication sharedApplication] windows].firstObject;
    UIGraphicsBeginImageContextWithOptions(w.bounds.size,
                                           NO,
                                           w.screen.scale);
    
    [w drawViewHierarchyInRect:w.frame afterScreenUpdates:NO];

    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIImage *blurredSnapshotImage = [snapshotImage applyBlurWithRadius:4
                                                             tintColor:[UIColor colorWithWhite:0.f alpha:0.1]
                                                 saturationDeltaFactor:1.f
                                                             maskImage:nil];
    
    UIGraphicsEndImageContext();
    UIImageView *iv = [[UIImageView alloc] initWithImage:blurredSnapshotImage];
    iv.alpha = 0.f;
    [self.view insertSubview:iv belowSubview:self.buttonView];
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.view.frame = w.bounds;
    [w addSubview:self.view];
    self.buttonView.frame = CGRectMake(0.f,
                                       self.view.height,
                                       self.view.width,
                                       self.items.count * buttonHeight);
    [UIView animateWithDuration:0.15
                          delay:0.f
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         iv.alpha = 1.f;
                         self.buttonView.top = self.view.height - self.items.count * buttonHeight;
                     }
                     completion:nil];
}

- (void)dismiss {
    // we remove buttons and unsetitems because
    // we'd otherwise have a retain cycle introduced by the cancel button;
    [self _removeButtons];
    self.items = nil;
    [self.view removeFromSuperview];
}


@end
