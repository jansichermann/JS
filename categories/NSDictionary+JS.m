#import "NSDictionary+JS.h"

@implementation NSDictionary (JS)

- (NSDictionary *)dictionaryBySettingObject:(NSObject *)object
                                     forKey:(id)key {
    if (key == nil) {
        return self;
    }
    
    NSMutableDictionary *d = [NSMutableDictionary dictionaryWithDictionary:self];
    if (object == nil) {
        [d removeObjectForKey:key];
    }
    else {
        d[key] = object;
    }
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

- (NSObject *)nestedObjectOrNil:(NSString *)path {
    NSArray *components = [path componentsSeparatedByString:@"."];
    NSUInteger compIndex = 0;
    NSObject *obj = self;
    
    while (YES) {
        NSString *key = [components objectAtIndex:compIndex];
        if (!key) {
            break;
        }
        if (obj && [obj isKindOfClass:[NSDictionary class]]) {
            obj = [(NSDictionary *)obj objectForKey:key];
        }
    }
    
    return obj;
}

@end
