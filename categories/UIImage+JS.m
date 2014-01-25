#import "UIImage+JS.h"

@implementation UIImage (JS)

+ (UIImage *)named:(NSString *)imageName {
    UIImage *i = [UIImage imageNamed:imageName];
    NSParameterAssert(i != nil);
    return i;
}

@end
