#import "NSAttributedString+JS.h"



@implementation NSAttributedString (JS)

+ (NSAttributedString *)withString:(NSString *)string
                              font:(UIFont *)font
                             color:(UIColor *)color {
    return [self withString:string
                       font:font
                      color:color
                  alignment:NSTextAlignmentLeft];
}

+ (NSAttributedString *)withString:(NSString *)string
                              font:(UIFont *)font
                             color:(UIColor *)color
                         alignment:(NSTextAlignment)alignment {
    
    if (string && [string isKindOfClass:[NSString class]]) {
        
        NSMutableParagraphStyle *p = [NSParagraphStyle defaultParagraphStyle].mutableCopy;
        p.alignment = alignment;
        
        return [[NSAttributedString alloc] initWithString:string
                                               attributes:
                @{
                  NSForegroundColorAttributeName : color,
                  NSFontAttributeName : font,
                  NSParagraphStyleAttributeName : p.copy
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
