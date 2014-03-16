#import "JSInsetImageView.h"
#import "UIView+JS.h"

@interface JSInsetImageView ()
@property (nonatomic, readwrite)         JSImageView         *imageView;
@end

@implementation JSInsetImageView

+ (instancetype)insetImageViewWithFrame:(CGRect)frame
                                  inset:(UIEdgeInsets)edgeInsets
                        backgroundColor:(UIColor *)color
                                 circle:(BOOL)circle {
    JSInsetImageView *i = [[self alloc] init];
    i.frame = frame;
    i.backgroundColor = color;
    i.imageView.frame = CGRectMake(edgeInsets.left,
                                   edgeInsets.top,
                                   i.width - edgeInsets.left - edgeInsets.right,
                                   i.height - edgeInsets.top - edgeInsets.bottom);
    i.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [i addSubview:i.imageView];
    if (circle) {
        i.clipsToBounds = YES;
        i.imageView.clipsToBounds = YES;
        i.layer.cornerRadius = i.width / 2.f;
        i.imageView.layer.cornerRadius = i.imageView.width / 2.f;
        i.imageView.clipsToBounds = YES;
    }
    return i;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (!self) {
        return nil;
    }
    self.imageView = [[JSImageView alloc] init];
    return self;
}

@end
