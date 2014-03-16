#import "BaseModelObject+Archiving.h"

@implementation BaseModelObject (Archiving)

- (void)jss_persistToPath:(NSString *)path {
    [NSKeyedArchiver archiveRootObject:self
                                toFile:path];
}

+ (instancetype)jss_loadFromPath:(NSString *)path {
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return nil;
    }
    return [NSKeyedUnarchiver unarchiveObjectWithFile:path];
}

@end
