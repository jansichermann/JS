#import "JSSegmentedControl.h"
#import "NSArray+JS.h"



@interface JSSegmentedControlModel ()
@property (nonatomic)       NSString            *title;
@property (nonatomic, copy) OnSegmentClickBlock clickBlock;
@end

@implementation JSSegmentedControlModel
+ (instancetype)withTitle:(NSString *)title
             onClickBlock:(OnSegmentClickBlock)block {
    JSSegmentedControlModel *s = [[JSSegmentedControlModel alloc] init];
    s.title = title;
    s.clickBlock = block;
    return s;
}

@end



@interface JSSegmentedControl ()
@property (nonatomic)   NSArray         *jsSegmentedControlModels;
@end



@implementation JSSegmentedControl

- (instancetype)initWithJSSegmentItems:(NSArray *)segmentItems {
    NSParameterAssert(segmentItems.count > 0);
    NSMutableArray *titleArray = [NSMutableArray arrayWithCapacity:segmentItems.count];
    for (JSSegmentedControlModel *m in segmentItems) {
        NSParameterAssert([m isKindOfClass:[JSSegmentedControlModel class]]);
        [titleArray addObject:m.title];
    }
    self = [super initWithItems:titleArray.copy];
    if (!self) {
        return nil;
    }
    self.jsSegmentedControlModels = segmentItems;
    [self addTarget:self
             action:@selector(controlChanged:)
   forControlEvents:UIControlEventValueChanged];
    return self;
}

- (id)init {
    @throw @"NDI";
}

- (id)initWithItems:(NSArray *)items {
    @throw @"NDI";
}

- (void)controlChanged:(JSSegmentedControl *)control {
    JSSegmentedControlModel *m =
    [self.jsSegmentedControlModels objectAtIndexOrNil:control.selectedSegmentIndex];
    NSParameterAssert([m isKindOfClass:[JSSegmentedControlModel class]]);
    if (m.clickBlock) {
        m.clickBlock();
    }
}
@end
