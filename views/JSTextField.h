#import <UIKit/UIKit.h>



/**
 Created by jan on 12/2/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */

@class JSTextField;

typedef void(^JSTextFieldDelegateBlock)(JSTextField *tf);


@interface JSTextField : UITextField
@property (nonatomic, copy)         JSTextFieldDelegateBlock        onValueChangeBlock;
@property (nonatomic, copy)         JSTextFieldDelegateBlock        onDidEndEditingBlock;
@property (nonatomic, copy)         JSTextFieldDelegateBlock        onEditingDidEndOnExitBlock;
@property (nonatomic, copy)         JSTextFieldDelegateBlock        onDidBeginEditingBlock;
@end
