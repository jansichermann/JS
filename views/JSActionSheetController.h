#import <UIKit/UIKit.h>



/**
 Created by jan on 12/5/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */

typedef void(^OnClickBlock)();

@interface JSActionSheetItem : NSObject
+ (instancetype)withTitle:(NSString *)title
               titleColor:(UIColor *)color
                titleFont:(UIFont *)titleFont
                  onClick:(OnClickBlock)onClickBlock;
@end



@interface JSActionSheetController : UIViewController
+ (instancetype)withItems:(NSArray *)items
   cancelButtonTitleColor:(UIColor *)titleColor
    cancelButtonTitleFont:(UIFont *)titleFont;
- (void)present;
- (void)dismiss;
@end
