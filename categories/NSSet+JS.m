#import "NSSet+JS.h"

@implementation NSSet (JS)

- (NSSet *)setByRemovingObject:(NSObject *)obj {
    NSMutableSet *s = self.mutableCopy;
    [s removeObject:obj];
    return s.copy;
}

- (NSSet *)setByRemovingObjects:(NSSet *)objects {
    NSMutableSet *s = self.mutableCopy;
    [s minusSet:objects];
    return s.copy;
}

@end
