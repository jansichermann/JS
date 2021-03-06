#import <UIKit/UIKit.h>



/**
 Created by jan on 1/24/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface UIImage (JS)
+ (UIImage *)named:(NSString *)imageName;
+ (UIImage *)withImage:(UIImage *)image
          scaledToSize:(CGSize)size;
- (UIImage *)scaledToSize:(CGSize)size;
- (UIImage *)scaledToMaxWidth:(CGFloat)maxWidth;
@end
