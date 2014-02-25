#import "JSImageView.h"


/**
 Created by jan on 11/29/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSInsetImageView : UIView
@property (nonatomic, readonly)         JSImageView         *imageView;

+ (instancetype)insetImageViewWithFrame:(CGRect)frame
                                  inset:(UIEdgeInsets)edgeInsets
                        backgroundColor:(UIColor *)color
                                 circle:(BOOL)circle ;
@end
