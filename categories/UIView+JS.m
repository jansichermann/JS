#import "UIView+JS.h"

@implementation UIView (JS)

- (CGFloat)top {
    return CGRectGetMinY(self.frame);
}

- (void)setTop:(CGFloat)top {
    self.frame = CGRectMake(self.left,
                            top,
                            self.width,
                            self.height);
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.left,
                            self.top,
                            width,
                            self.height);
}

- (CGFloat)width {
    return CGRectGetWidth(self.frame);
}

- (CGFloat)height {
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.left,
                            self.top,
                            self.width,
                            height);
}

- (CGFloat)bottom {
    return CGRectGetMaxY(self.frame);
}
- (void)setBottom:(CGFloat)bottom {
    self.frame = CGRectMake(self.left,
                            bottom - self.height,
                            self.width,
                            self.height);
}

- (void)setRight:(CGFloat)right {
    self.frame = CGRectMake(right - self.width,
                            self.top,
                            self.width,
                            self.height);
}

- (CGFloat)right {
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)verticalCenter {
    return self.top + self.height / 2.f;
}

- (CGFloat)horizontalCenter {
    return self.left + self.width / 2.f;
}

- (CGFloat)left {
    return CGRectGetMinX(self.frame);
}

- (void)setLeft:(CGFloat)left {
    self.frame = CGRectMake(left,
                            self.top,
                            self.width,
                            self.height);
}

- (void)centerInSuperview {
    [self centerHorizontallyInSuperview];
    [self centerVerticallyInSuperview];
}

- (void)centerVerticallyInSuperview {
    self.top = (self.superview.height / 2) - (self.height / 2);
}

- (void)centerHorizontallyInSuperview {
    self.left = (self.superview.width / 2) - (self.width / 2);
}

- (void)centerVerticallyToView:(UIView *)v {
    self.top = v.top + (v.height / 2.f) - (self.height / 2.f);
}

- (UIImage *)snapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size,
                                           NO,
                                           [UIScreen mainScreen].scale);
    
    [self drawViewHierarchyInRect:self.frame
               afterScreenUpdates:NO];
    
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return snapshotImage;
}


@end
