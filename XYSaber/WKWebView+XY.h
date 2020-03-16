//
//  WKWebView+XY.h
//  XYKit
//
//  Created by lxy on 2019/10/23.
//  Copyright © 2019 lxy. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (XY)

@property (nonatomic,readonly,copy) NSString *url;
@property (nonatomic,readonly,copy) NSString *html;
@property (nonatomic,readonly,copy) NSString *videoUrl;

@end


