#import "UIColor+JS.h"

@implementation UIColor (JS)

+ (UIColor *)colorWithHex:(UInt32)col {
    return [self colorWithHex:col alpha:1.f];
}

+ (UIColor *)colorWithHex:(UInt32)col
                    alpha:(CGFloat)alpha {
    unsigned char r, g, b;
    b = col & 0xFF;
    g = (col >> 8) & 0xFF;
    r = (col >> 16) & 0xFF;
    return [UIColor colorWithRed:(float)r/255.0f green:(float)g/255.0f blue:(float)b/255.0f alpha:alpha];
}

@end
