#import <UIKit/UIKit.h>
#import "NSAttributedString+JS.h"



/**
 Created by jan on 3/4/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface NSAttributedString (JS)
+ (NSAttributedString *)withString:(NSString *)string
                              font:(UIFont *)font
                             color:(UIColor *)color
                         alignment:(NSTextAlignment)alignment;

+ (NSAttributedString *)withString:(NSString *)string
                              font:(UIFont *)font
                             color:(UIColor *)color;

+ (NSAttributedString *)withString:(NSString *)string
                             color:(UIColor *)color;
@end
