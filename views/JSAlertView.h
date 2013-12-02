#import <UIKit/UIKit.h>

typedef void(^OnClickBlock)();

@interface JSAlertViewButtonItem : NSObject
+ (instancetype)withTitle:(NSString *)title
             onClickBlock:(OnClickBlock)block;
@end


/**
 Created by jan on 12/1/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSAlertView : UIAlertView
+ (instancetype)withTitle:(NSString *)title
                  message:(NSString *)message
   jsAlertViewButtonItems:(NSArray *)buttonItems;
@end
