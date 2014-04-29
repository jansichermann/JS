#import "NSDate+JS.h"

@implementation NSDate (JS)

+ (instancetype)dateInCurrentCalendarForComponents:(NSDateComponents *)comps {
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

- (NSDateComponents *)componentsForCurrentCalendar {
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:
                               NSCalendarUnitYear
                               | NSCalendarUnitMonth
                               | NSCalendarUnitDay
                               | NSCalendarUnitHour
                               | NSCalendarUnitMinute
                               | NSCalendarUnitWeekday
                               | NSCalendarUnitWeekOfYear
                               | NSCalendarUnitWeekOfMonth
                                               fromDate:self];
    return comps;
}
@end
