#import "JSTextView.h"


@interface JSTextView()
<
UITextViewDelegate
>
@end



@implementation JSTextView

- (id)initWithFrame:(CGRect)frame
      textContainer:(NSTextContainer *)textContainer {
    self = [super initWithFrame:frame
                  textContainer:textContainer];
    if (!self) {
        return nil;
    }
    self.delegate = self;
    return self;
}

- (id)init {
    @throw @"NDI";
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if (self.onDidBeginEditingBlock) {
        self.onDidBeginEditingBlock(textView);
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.onDidChangeBlock) {
        self.onDidChangeBlock(textView);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.onDidEndEditingBlock) {
        self.onDidEndEditingBlock(textView);
    }
}

@end
