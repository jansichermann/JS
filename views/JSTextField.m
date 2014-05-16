#import "JSTextField.h"

@interface JSTextField()
@end

@implementation JSTextField

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (!self) {
        return nil;
    }
    
    [self addTarget:self
             action:@selector(textFieldValueChanged:)
   forControlEvents:UIControlEventEditingChanged];
    
    [self addTarget:self
             action:@selector(textFieldDidBeginEditing:)
   forControlEvents:UIControlEventEditingDidBegin];
    
    [self addTarget:self
             action:@selector(textFieldEditingDidEndOnExit:)
   forControlEvents:UIControlEventEditingDidEndOnExit];
    
    [self addTarget:self
             action:@selector(textFieldDidEndEditing:)
   forControlEvents:UIControlEventEditingDidEnd];

    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)tf {
    NSParameterAssert([tf isKindOfClass:[JSTextField class]]);
    if (self.onDidEndEditingBlock) {
        self.onDidEndEditingBlock((JSTextField *)tf);
    }
}

- (void)textFieldEditingDidEndOnExit:(UITextField *)tf {
    NSParameterAssert([tf isKindOfClass:[JSTextField class]]);
    if (self.onEditingDidEndOnExitBlock) {
        self.onEditingDidEndOnExitBlock((JSTextField *)tf);
    }
}

- (void)textFieldValueChanged:(UITextField *)tf {
    NSParameterAssert([tf isKindOfClass:[JSTextField class]]);
    if (self.onValueChangeBlock) {
        self.onValueChangeBlock((JSTextField *)tf);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)tf {
    NSParameterAssert([tf isKindOfClass:[JSTextField class]]);
    if (self.onDidBeginEditingBlock) {
        self.onDidBeginEditingBlock((JSTextField *)tf);
    }
}

@end
