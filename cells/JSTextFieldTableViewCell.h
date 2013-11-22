#import "JSTableViewCell.h"


/**
 Created by jan on 11/19/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */

typedef void(^OnResignBlock)(UITextField *tf);

@interface JSTextFieldTableViewCellModel : NSObject

+ (instancetype)withOnResignBlock:(OnResignBlock)onResignBlock
                  placeholderText:(NSString *)placeholderText;

@end



/**
 Created by jan on 11/19/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */

@interface JSTextFieldTableViewCell : JSTableViewCell

@end
