#import "UIBarButtonItem+JSButton.h"
#import "JSButton.h"



@implementation UIBarButtonItem (JSButton)

+ (instancetype)barButtonItemWithTitle:(NSString *)title
                                  font:(UIFont *)font
                            clickBlock:(void(^)())block {
    JSButton *b = [JSButton buttonWithType:UIButtonTypeSystem];
    [b setTitle:title forState:UIControlStateNormal];
    b.titleLabel.font = font;
    b.touchUpInsideBlock = ^(__unused JSButton *b) {
        block();
    };
    [b sizeToFit];
    
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:b];
    return bb;
}

+ (instancetype)barButtonItemWithImage:(UIImage *)image
                            clickBlock:(void(^)())block {
    JSButton *b = [JSButton buttonWithType:UIButtonTypeSystem];
    [b setImage:image forState:UIControlStateNormal];
    b.touchUpInsideBlock = ^(__unused JSButton *b) {
        block();
    };
    [b sizeToFit];
    
    UIBarButtonItem *bb = [[UIBarButtonItem alloc] initWithCustomView:b];
    return bb;

}

@end
