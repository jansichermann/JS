#import "JSViewController.h"

#include "JSMacros.h"

#import "UIView+JS.h"




@interface JSViewController ()
@property (nonatomic)                   BOOL                didRegisterKeyboardObserver;
@property (nonatomic, readwrite)        NSUInteger          appearanceCount;
@end



@implementation JSViewController



#pragma mark - Keyboard

- (BOOL)shouldObserveKeyboard {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if ([self shouldObserveKeyboard]) {
        [self registerForKeyboardNotification];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.appearanceCount++;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.didRegisterKeyboardObserver) {
        [self unregisterFromKeyboardNotifications];
    }
}

- (void)registerForKeyboardNotification {
    self.didRegisterKeyboardObserver = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)unregisterFromKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
    self.didRegisterKeyboardObserver = NO;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGRect r = [(NSValue *)[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
    UIWindow *w = [[UIApplication sharedApplication] windows].lastObject;
    CGPoint p = [self.view convertPoint:r.origin
                               fromView:w];
        
    float height = p.y;
    __weak JSViewController *weak_self = self;
        
    [UIView animateWithDuration:[[notification.userInfo
                                  objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0.f
                        options:(UIViewAnimationOptions)[[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]
                     animations:^ {
                         weak_self.view.height = height;
                     }
                     completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)notification {
        CGRect r =
        [(NSValue *)[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
        
        UIWindow *w = [[UIApplication sharedApplication] windows].lastObject;
        CGPoint p = [self.view convertPoint:r.origin
                                   fromView:w];
        
        float height = p.y;
        [UIView animateWithDuration:[[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                              delay:0.f
                            options:(UIViewAnimationOptions)[[notification.userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]
                         animations:^ {
                             self.view.height = height;
                         }
                         completion:nil];
}


#pragma mark - Reload

- (void)reloadData { }

- (void)dismissSelfAnimated {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}
@end
