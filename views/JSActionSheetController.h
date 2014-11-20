#import <UIKit/UIKit.h>



/**
 Created by jan on 12/5/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */

typedef void(^OnClickBlock)();

@interface JSActionSheetItem : NSObject
+ (instancetype)infoItemWithText:(NSAttributedString *)text;
+ (instancetype)withTitle:(NSString *)title
               titleColor:(UIColor *)color
                titleFont:(UIFont *)titleFont
                  onClick:(OnClickBlock)onClickBlock;
@end



@interface JSActionSheetController : UIViewController

@property (nonatomic) BOOL shouldBlur;

+ (instancetype)withItems:(NSArray *)items
   cancelButtonTitleColor:(UIColor *)titleColor
    cancelButtonTitleFont:(UIFont *)titleFont;
- (void)present;
- (void)dismiss;
@end
