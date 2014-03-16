#import "JSImageView.h"


@interface JSImageView ()
@property (nonatomic, weak) NSURLSessionTask *sessionTask;
@end



@implementation JSImageView

- (void)loadImageFromUrlString:(NSString *)urlString
                   withSession:(NSURLSession *)session {
    if (urlString.length == 0) {
        self.image = nil;
        return;
    }
    NSURLSessionTask *t =
[session dataTaskWithURL:[NSURL URLWithString:urlString]
                              completionHandler:
                        ^(NSData *data,
                          __unused NSURLResponse *response,
                          __unused NSError *error) {
                            UIImage *i = [UIImage imageWithData:data];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                self.image = i;
                            });
                        }];
    [t resume];
    self.sessionTask = t;
}

- (void)cancelLoad {
    NSURLSessionTask *t = self.sessionTask;
    [t cancel];
}

@end
