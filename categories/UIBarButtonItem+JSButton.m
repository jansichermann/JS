#import "UIBarButtonItem+JSButton.h"
#import "JSButton.h"



@implementation UIBarButtonItem (JSButton)

+ (instancetype)barbuttonItemWithTitle:(NSString *)title
                            clickBlock:(void(^)())block {
    UIFont *f = [[UIBarButtonItem appearance] titleTextAttributesForState:UIControlStateNormal][NSFontAttributeName];
    if (!f) {
        f = [UIFont systemFontOfSize:[UIFont systemFontSize]];
    }
    return [self barButtonItemWithTitle:title
                                   font:f
                             clickBlock:block];
}

+ (instancetype)barButtonItemWithTitle:(NSString *)title
                                  font:(UIFont *)font
                            clickBlock:(void(^)())block {
    JSButton *b = [JSButton buttonWithType:UIButtonTypeSystem];
    [b setTitle:title forState:UIControlStateNormal];
    b.titleLabel.font = font;
    if (block) {
        b.touchUpInsideBlock = ^(__unused JSButton *bb) {
            block();
        };
    }
    [b sizeToFit];
    
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:b];
    return bb;
}

+ (instancetype)barButtonItemWithImage:(UIImage *)image
                            clickBlock:(void(^)())block {
    JSButton *b = [JSButton buttonWithType:UIButtonTypeSystem];
    b.touchUpInsideBlock = ^(__unused JSButton *bb) {
        block();
    };
    [b setImage:image
       forState:UIControlStateNormal];
    [b sizeToFit];
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:b];
    return bb;
}

@end
