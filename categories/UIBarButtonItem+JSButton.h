#import <UIKit/UIKit.h>


/**
 Created by jan on 11/30/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface UIBarButtonItem (JSButton)

+ (instancetype)barbuttonItemWithTitle:(NSString *)title
                            clickBlock:(void(^)())block;

+ (instancetype)barButtonItemWithTitle:(NSString *)title
                                  font:(UIFont *)font
                            clickBlock:(void(^)())block;

+ (instancetype)barButtonItemWithImage:(UIImage *)image
                            clickBlock:(void(^)())block;

@end
