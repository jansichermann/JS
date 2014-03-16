#import <UIKit/UIKit.h>



/**
 Created by jan on 3/9/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */

typedef void(^TextViewBlock)(UITextView *tf);

@interface JSTextView : UITextView
@property (nonatomic, copy)     TextViewBlock       onDidEndEditingBlock;
@property (nonatomic, copy)     TextViewBlock       onDidChangeBlock;
@end
