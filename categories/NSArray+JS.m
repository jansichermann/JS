#import "NSArray+JS.h"

@implementation NSArray (JS)

- (id)objectAtIndexOrNil:(NSInteger)index {
    if (index >= (NSInteger)self.count) {
        return nil;
    }
    if (index < 0) {
        return self[(NSUInteger) (index + (NSInteger)self.count)];
    }
    return self[(NSUInteger)index];
}

- (NSArray *)arrayByRemovingObject:(NSObject *)object {
    if (![self containsObject:object]) {
        return self;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self];
    [arr removeObject:object];
    return arr.copy;
}

@end
