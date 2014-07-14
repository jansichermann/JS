#import <Foundation/Foundation.h>



/**
 Created by jan on 2/19/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface NSDictionary (JS)
- (NSDictionary *)dictionaryBySettingObject:(NSObject *)object
                                     forKey:(id)key;
- (NSDictionary *)dictionaryByRemovingObjectForKey:(NSString *)key;
- (NSObject *)nestedObjectOrNil:(NSString *)path;

/**
 @param keyTranslation A NSDictionary where the keys are the old keys, and values are the new keys
 @return A NSDictionary, where keys have been remapped.
 @discussion This omits all keys not listed in keyTranslation.
 @see dictionaryWithTransferedKeysToKeys:
 */
- (NSDictionary *)dictionaryWithCopiedKeysToKeys:(NSDictionary *)keyTranslation;

/**
 @discussion Similar to dictionaryWithCopiedKeysToKeys: except all non-mentioned keys in the keyTranslation are still present
 */
- (NSDictionary *)dictionaryWithTransferredKeysToKeys:(NSDictionary *)keyTranslation;
@end
