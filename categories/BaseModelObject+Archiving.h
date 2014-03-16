#import "BaseModelObject.h"



/**
 Created by jan on 3/15/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface BaseModelObject (Archiving)

- (void)jss_persistToPath:(NSString *)path;
+ (instancetype)jss_loadFromPath:(NSString *)path;

@end
