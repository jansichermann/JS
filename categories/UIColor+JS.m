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

+ (UIColor *)colorFromHexString:(NSString *)hexString {
    NSParameterAssert([[hexString substringToIndex:1] isEqualToString:@"#"]);
    unsigned v = 0;
    NSScanner *s = [NSScanner scannerWithString:hexString];
    [s setScanLocation:1];
    [s scanHexInt:&v];
    return [UIColor colorWithRed:((v & 0xFF0000) >> 16)/255.0
                           green:((v & 0xFF00) >> 8)/255.0
                            blue:(v & 0xFF)/255.0 alpha:1.0];
}

@end
