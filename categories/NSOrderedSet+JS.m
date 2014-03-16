#import "NSOrderedSet+JS.h"

@implementation NSOrderedSet (JS)

- (id)objectAtIndexOrNil:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
