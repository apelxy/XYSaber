//
//  XYImageViewSupport.m
//  XYKit
//
//  Created by lxy on 2020/1/15.
//  Copyright © 2020 ios. All rights reserved.
//

#import "XYImageViewSupport.h"

@implementation XYImageViewSupport
+(instancetype)shared{
    static XYImageViewSupport *imageViewSupport = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        imageViewSupport = [[XYImageViewSupport alloc]init];
    });
    return imageViewSupport;
}
-(NSMutableDictionary*)imageDic{
    if (!_imageDic) {
        _imageDic = [NSMutableDictionary dictionary];
    }
    return _imageDic;
}
-(NSString*)sandboxPath{
    return @"XiangYangImageViewPath";
}
@end
