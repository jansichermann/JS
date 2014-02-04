#import <UIKit/UIKit.h>



typedef void(^OnSegmentClickBlock)();

/**
 The Model Class for JSSegmentedControl
 Created by jan on 2/3/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */

@interface JSSegmentedControlModel : NSObject
+ (instancetype)withTitle:(NSString *)title
             onClickBlock:(OnSegmentClickBlock)block;
@end



/**
 A Block based Segmented Control.
 Created by jan on 2/3/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */

@interface JSSegmentedControl : UISegmentedControl
/**
 @discussion This is the designated initializer. Expects an array of JSSegmentedControlModel items.
 */
- (instancetype)initWithJSSegmentItems:(NSArray *)segmentItems;

@end
