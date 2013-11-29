#import "JSTableViewCell.h"


/**
 Created by jan on 11/19/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */

typedef void(^ChangeBlock)(UITextField *tf);

@interface JSTextFieldTableViewCellModel : NSObject

+ (instancetype)withOnDidEndEditingBlock:(ChangeBlock)onDidEndEditingBlock
                        onDidResignBlock:(ChangeBlock)onDidResignBlock
                      onValueChangeBlock:(ChangeBlock)onValueChangeBlock
                         placeholderText:(NSString *)placeholderText
                             initialText:(NSString *)initialText;

@end



/**
 Created by jan on 11/19/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */

@interface JSTextFieldTableViewCell : JSTableViewCell
@property (nonatomic, readonly)       UITextField                     *textField;
@end
