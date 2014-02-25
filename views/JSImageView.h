#import <UIKit/UIKit.h>

/**
 Created by jan on 2/23/14. Copyright (c) 2014 Jan Sichermann. All rights reserved.
 */


@interface JSImageView : UIImageView
- (void)loadImageFromUrlString:(NSString *)urlString
                   withSession:(NSURLSession *)session;
- (void)cancelLoad;
@end
