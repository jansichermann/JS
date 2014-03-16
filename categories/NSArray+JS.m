#import "NSArray+JS.h"

@implementation NSArray (JS)

- (id)objectAtIndexOrNil:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return self[index];
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
