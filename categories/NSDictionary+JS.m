#import "NSDictionary+JS.h"

@implementation NSDictionary (JS)

- (NSDictionary *)dictionaryBySettingObject:(NSObject *)object
                                     forKey:(id)key {
    if (object == nil || key == nil) {
        return self;
    }
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:self];
    d[key] = object;
    return d.copy;
}

- (NSDictionary *)dictionaryByRemovingObjectForKey:(NSString *)key {
    if (key == nil) {
        return self;
    }
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:self];
    [d removeObjectForKey:key];
    return d.copy;
}

@end