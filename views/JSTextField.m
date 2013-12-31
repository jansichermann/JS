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
             action:@selector(textFieldDidBeginEditing:) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self
             action:@selector(textFieldEditingDidEndOnExit:)
   forControlEvents:UIControlEventEditingDidEndOnExit];
    [self addTarget:self
             action:@selector(textFieldDidEndEditing:)
   forControlEvents:UIControlEventEditingDidEnd];

    return self;
}

- (void)textFieldDidEndEditing:(UITextField *)tf {
    if (self.onDidEndEditingBlock) {
        self.onDidEndEditingBlock(tf);
    }
}

- (void)textFieldEditingDidEndOnExit:(UITextField *)tf {
    if (self.onEditingDidEndOnExitBlock) {
        self.onEditingDidEndOnExitBlock(tf);
    }
}

- (void)textFieldValueChanged:(UITextField *)tf {
    if (self.onValueChangeBlock) {
        self.onValueChangeBlock(tf);
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)tf {
    if (self.onDidBeginEditing) {
        self.onDidBeginEditing(tf);
    }
}

@end
