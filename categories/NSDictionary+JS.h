#import <Foundation/Foundation.h>



/**
 Created by jan on 2/19/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
*/



@interface NSDictionary (JS)
- (NSDictionary *)dictionaryBySettingObject:(NSObject *)object
                                     forKey:(NSObject <NSCopying> *)key;
- (NSDictionary *)dictionaryBySettingObjectsInDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryByRemovingObjectForKey:(NSObject <NSCopying> *)key;
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
