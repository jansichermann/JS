#import "JSTableViewCell.h"



typedef NS_ENUM(NSInteger, JSSwipeableTableViewCellSwipeDirection) {
    JSSwipeableTableViewCellSwipeNone = 0,
    JSSwipeableTableViewCellSwipeToLeft = 1 << 0,
    JSSwipeableTableViewCellSwipeToRight = 1 << 1
};


@interface JSSwipeableTableViewCellModel : NSObject

@property (nonatomic) JSSwipeableTableViewCellSwipeDirection swipeableDirections;
@property (nonatomic, copy) void(^onSwipeHandler)(UITableViewCell *cell, CGFloat swipeOffset);
@property (nonatomic, copy) void(^swipeTriggerHandler)(UITableViewCell *cell, JSSwipeableTableViewCellSwipeDirection direction);

@property (nonatomic) UIColor *leftColor;
@property (nonatomic) UIColor *rightColor;

@property (nonatomic) NSAttributedString *leftTitle;
@property (nonatomic) NSAttributedString *rightTitle;

@end


/**
 Created by Jan Sichermann on 11/12/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */



@interface JSSwipeableTableViewCell : JSTableViewCell

@property (nonatomic, readonly) UIView *swipeView;
- (void)setSwipeOffsetPercentage:(CGFloat)offset
                        animated:(BOOL)animated; // ranges from -1 (left) to +1 (right).
@end
