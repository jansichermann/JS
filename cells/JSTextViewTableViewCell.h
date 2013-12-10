#import "JSTableViewCell.h"

typedef void(^TextViewBlock)(UITextView *tv);


@interface JSTextViewTableViewCellModel : NSObject

+ (instancetype)withOnValueChangeBlock:(TextViewBlock)block
                onDidBeginEditingBlock:(TextViewBlock)didBeginEditingBlock;

+ (instancetype)withOnValueChangeBlock:(TextViewBlock)block
                onDidBeginEditingBlock:(TextViewBlock)didBeginEditingBlock
                  onDidEndEditingBlock:(TextViewBlock)didEndEditingBlock
                                  icon:(UIImage *)icon
                           initialText:(NSAttributedString *)initialText
                       placeholderText:(NSAttributedString *)placeholderText;
@end




/**
 Created by jan on 11/29/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSTextViewTableViewCell : JSTableViewCell

@end
