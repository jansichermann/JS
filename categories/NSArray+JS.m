#import "NSArray+JS.h"

@implementation NSArray (JS)

- (id)objectAtIndexOrNil:(NSInteger)index {
    if (index >= (NSInteger)self.count) {
        return nil;
    }
    if (index < 0) {
        NSInteger newIndex = (NSInteger)index + (NSInteger)self.count;
        if (newIndex < 0) {
            return nil;
        }
        
        return [self objectAtIndexOrNil:newIndex];
    }
    return self[(NSUInteger)index];
}

- (instancetype)arrayByAddingObjectIfNotContained:(NSObject *)object {
    if (!object || [self containsObject:object]) {
        return self;
    }
    
    return [self arrayByAddingObject:object];
    
}

- (NSArray *)arrayByRemovingObject:(NSObject *)object {
    if (![self containsObject:object]) {
        return self;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self];
    [arr removeObject:object];
    return arr.copy;
}


- (NSArray *)arrayByPrependingObject:(NSObject *)object {
    if (!object) {
        return self;
    }
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:self.count + 1];
    [arr addObject:object];
    [arr addObjectsFromArray:self];
    return arr.copy;
}

- (NSArray *)arrayByPrependingObjects:(NSArray *)objects {
    if (!objects || objects.count == 0) {
        return self;
    }
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:self.count + 1];
    [arr addObjectsFromArray:objects];
    [arr addObjectsFromArray:self];
    return arr.copy;
}



@end
