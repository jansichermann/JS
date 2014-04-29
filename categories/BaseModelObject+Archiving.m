#import "BaseModelObject+Archiving.h"

@implementation BaseModelObject (Archiving)

- (void)js__persistToPath:(NSString *)path {
    [NSKeyedArchiver archiveRootObject:self
                                toFile:path];
}

+ (instancetype)js__loadFromPath:(NSString *)path {
    BaseModelObject *bm = nil;
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
        return bm;
    }

    @try {
        bm = [NSKeyedUnarchiver unarchiveObjectWithFile:path];;
    }
    @catch (NSException *exception) {}
    
    return bm;
}

@end
