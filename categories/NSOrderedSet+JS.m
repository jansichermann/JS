#import "NSOrderedSet+JS.h"

@implementation NSOrderedSet (JS)

- (instancetype)orderedSetByAppendingOrderedSet:(NSOrderedSet *)set {
    if (!set || set.count == 0) {
        return self;
    }
    NSMutableOrderedSet *s = [NSMutableOrderedSet orderedSetWithOrderedSet:self];
    for (NSObject *o in set) {
        [s addObject:o];
    }
    return s.copy;
}

- (instancetype)orderedSetByRemovingObject:(NSObject *)object {
    if (![self containsObject:object]) {
        return self;
    }
    NSMutableOrderedSet *s = [NSMutableOrderedSet orderedSetWithOrderedSet:self];
    [s removeObject:object];
    return s.copy;
}

- (instancetype)orderedSetByAppendingObject:(NSObject *)object {
    if (!object) {
        return self;
    }
    
    NSMutableOrderedSet *s = [NSMutableOrderedSet orderedSetWithOrderedSet:self];
    [s addObject:object];
    return s.copy;
}

- (id)objectAtIndexOrNil:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self objectAtIndex:index];
}

@end
