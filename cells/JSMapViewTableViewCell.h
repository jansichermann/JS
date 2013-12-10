#import "JSTableViewCell.h"
@import MapKit.MKAnnotation;

@interface JSMapViewTableViewCellModel : NSObject
+ (instancetype)withHeight:(CGFloat)height
                annotation:(id<MKAnnotation>)annotation;
@end
/**
 Created by jan on 12/7/13. Copyright (c) 2013 Jan Sichermann. All rights reserved.
 */


@interface JSMapViewTableViewCell : JSTableViewCell

@end
