//
//  WKWebView+XY.m
//  XYKit
//
//  Created by lxy on 2019/10/23.
//  Copyright © 2019 lxy. All rights reserved.
//

#import "WKWebView+XY.h"
#import <objc/runtime.h>
#import "NSThread+XY.h"
@interface WKWebView ()

@end

@implementation WKWebView (XY)
-(NSString*)url{
    
    __block NSString *urlStr = @"";
    [self evaluateJavaScript:@"document.location.href" completionHandler:^(id _Nullable string, NSError * _Nullable error) {
        urlStr = string;
        [NSThread relieveWait];
    }];
    [NSThread wait];
    return urlStr;
}
-(NSString*)html{
    
    __block NSString *html = @"";
    [self evaluateJavaScript:@"document.body.outerHTML" completionHandler:^(id _Nullable string, NSError * _Nullable error) {
        html = string;
        [NSThread relieveWait];
    }];
    [NSThread wait];
    return html;
}
-(NSString*)videoUrl{
    
    __block NSString *videoStr = @"";
    [self evaluateJavaScript:@"(document.getElementsByTagName(\"video\")[0]).src" completionHandler:^(id _Nullable string, NSError * _Nullable error) {
        videoStr = string;
        [NSThread relieveWait];
    }];
    [NSThread wait];
    return videoStr;
}
@end
