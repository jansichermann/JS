#import "NSArray+JS.h"

@implementation NSArray (JS)

- (id)objectAtIndexOrNil:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return self[index];
}

@end
