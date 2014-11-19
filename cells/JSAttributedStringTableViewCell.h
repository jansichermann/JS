#import "JSTableViewCell.h"


@interface JSAttributedStringTableViewCellModel : NSObject
+ (instancetype)withText:(NSAttributedString *)text
        topBottomPadding:(CGFloat)topBottomPadding;
+ (instancetype)withText:(NSAttributedString *)text;
+ (instancetype)withText:(NSAttributedString *)text
                    icon:(UIImage *)icon;
+ (instancetype)withText:(NSAttributedString *)text
                    icon:(UIImage *)icon
        topBottomPadding:(CGFloat)topBottomPadding;
+ (instancetype)withText:(NSAttributedString *)text
                    icon:(UIImage *)icon
           accessoryIcon:(UIImage *)accessoryIcon
        topBottomPadding:(CGFloat)topBottomPadding;

+ (instancetype)withText:(NSAttributedString *)text
                    icon:(UIImage *)icon
     disclosureIndicator:(UITableViewCellAccessoryType)accessoryType
        topBottomPadding:(CGFloat)topBottomPadding;
@end

/**
 Created by jan on 11/18/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */



@interface JSAttributedStringTableViewCell : JSTableViewCell

@end
