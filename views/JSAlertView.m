#import "JSAlertView.h"
#import "NSArray+JS.h"



@interface JSAlertViewButtonItem()

@property (nonatomic)           NSString        *title;
@property (nonatomic, copy)     OnClickBlock    onClickBlock;

@end


@implementation JSAlertViewButtonItem

+ (instancetype)withTitle:(NSString *)title
             onClickBlock:(OnClickBlock)block {
    JSAlertViewButtonItem *item = [[JSAlertViewButtonItem alloc] init];
    item.title = title;
    item.onClickBlock = block;
    return item;
}

@end



@interface JSAlertView()
<
UIAlertViewDelegate
>
@property (nonatomic)           NSArray     *buttonItems;

@end



@implementation JSAlertView

+ (instancetype)withTitle:(NSString *)title
                  message:(NSString *)message
   jsAlertViewButtonItems:(NSArray *)buttonItems {
    JSAlertView *a = [[super alloc] init];
    a.title = title;
    a.message = message;
    
    a.delegate = a;
    a.buttonItems = buttonItems;
    
    for (JSAlertViewButtonItem *item in a.buttonItems) {
        NSParameterAssert([item isKindOfClass:[JSAlertViewButtonItem class]]);
        [a addButtonWithTitle:item.title];
    }
    return a;
}

- (void)alertView:(JSAlertView *)alertView
didDismissWithButtonIndex:(NSInteger)buttonIndex {
    
    JSAlertViewButtonItem *item = [alertView.buttonItems objectAtIndexOrNil:(NSUInteger)buttonIndex];
    if (item.onClickBlock) {
        item.onClickBlock();
    }
}

- (void)cancel {
    self.buttonItems = nil;
    [self dismissWithClickedButtonIndex:0
                               animated:YES];
}

@end
