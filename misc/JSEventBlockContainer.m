#import "JSEventBlockContainer.h"

@interface JSEventBlockContainer ()
@property (nonatomic, copy) TargetBlock block;
@end

@implementation JSEventBlockContainer


+ (instancetype)withBlock:(TargetBlock)tb {
    JSEventBlockContainer *eb = [[JSEventBlockContainer alloc] init];
    eb.block = tb;
    return eb;
}

- (void)handleEvent:(id)sender {
    self.block(sender);
}
@end
