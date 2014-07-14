#import "UIImage+JS.h"

@implementation UIImage (JS)

+ (UIImage *)named:(NSString *)imageName {
    UIImage *i = [UIImage imageNamed:imageName];
    NSParameterAssert(i != nil);
    return i;
}

+ (UIImage *)withImage:(UIImage *)image
          scaledToSize:(CGSize)size {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.f);
    [image drawInRect:CGRectMake(0.f,
                                 0.f,
                                 size.width,
                                 size.height)];
    
    UIImage *i = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return i;
}

- (UIImage *)scaledToSize:(CGSize)size {
    return [self.class withImage:self
                    scaledToSize:size];
}

- (UIImage *)scaledToMaxWidth:(CGFloat)maxWidth {
    if (self.size.width <= maxWidth) {
        return self;
    }
    
    return [self scaledToSize:CGSizeMake(maxWidth,
                                         self.size.height / (self.size.width / maxWidth))];
}

@end
