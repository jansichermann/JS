#import <Foundation/Foundation.h>



/**
 Created by jan on 12/3/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */


@interface NSDate (JS)
+ (instancetype)dateInCurrentCalendarForComponents:(NSDateComponents *)comps;
- (NSDateComponents *)componentsForCurrentCalendar;
@end
