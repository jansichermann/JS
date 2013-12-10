#import "JSTableViewCell.h"
#import "JSTextField.h"

/**
 Created by jan on 11/19/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */

@interface JSTextFieldTableViewCellModel : NSObject

+ (instancetype)withOnDidEndEditingBlock:(JSTextFieldDelegateBlock)onDidEndEditingBlock
                        onEditingDidEndOnExitBlock:(JSTextFieldDelegateBlock)onEditingDidEndOnExitBlock
                      onValueChangeBlock:(JSTextFieldDelegateBlock)onValueChangeBlock
                                    font:(UIFont *)font
                                    icon:(UIImage *)icon
                         placeholderText:(NSString *)placeholderText
                             initialText:(NSString *)initialText
                               textColor:(UIColor *)color;
@end



/**
 Created by jan on 11/19/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */

@interface JSTextFieldTableViewCell : JSTableViewCell
<
JSTableViewCellProtocol
>
@end
