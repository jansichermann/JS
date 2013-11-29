//  Created by jan on 11/25/13.
//  Copyright (c) 2013 Jan Sichermann. All rights reserved.

#define WEAK(_obj) \
__weak __typeof__(_obj) weak_ ## _obj = _obj

