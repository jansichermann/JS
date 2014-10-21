#import "NSAttributedString+JS.h"



@implementation NSAttributedString (JS)

+ (NSAttributedString *)withString:(NSString *)string
                              font:(UIFont *)font
                             color:(UIColor *)color {
    if (string && [string isKindOfClass:[NSString class]]) {
        return [[NSAttributedString alloc] initWithString:string
                                               attributes:
      @{
        NSForegroundColorAttributeName : color,
        NSFontAttributeName : font
        }];
    }
    return nil;
}

+ (NSAttributedString *)withString:(NSString *)string
                             color:(UIColor *)color {
    return [[NSAttributedString alloc] initWithString:string
                                           attributes:
            @{
              NSForegroundColorAttributeName : color
              }];
}

@end
