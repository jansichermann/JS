#import "NSAttributedString+JS.h"



@implementation NSAttributedString (JS)

+ (NSAttributedString *)withString:(NSString *)string
                              font:(UIFont *)font
                             color:(UIColor *)color {
    return [[NSAttributedString alloc] initWithString:string
                                           attributes:
  @{
    NSForegroundColorAttributeName : color,
    NSFontAttributeName : font
    }];
}

@end