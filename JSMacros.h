//  Created by jan on 11/25/13.
//  Copyright (c) 2013 Jan Sichermann. All rights reserved.

#define WEAK(_obj) \
__weak __typeof__(_obj) weak_ ## _obj = _obj

#define JSLog(s, ...) NSLog((@"%@: " s), [self class], ##__VA_ARGS__);


#define JSAssert(weak_self, condition, desc, ...)	\
do {				\
__PRAGMA_PUSH_NO_EXTRA_ARG_WARNINGS \
if (!(condition)) {		\
[[NSAssertionHandler currentHandler] handleFailureInMethod:_cmd \
object:weak_self file:[NSString stringWithUTF8String:__FILE__] \
lineNumber:__LINE__ description:(desc), ##__VA_ARGS__]; \
}				\
__PRAGMA_POP_NO_EXTRA_ARG_WARNINGS \
} while(0)