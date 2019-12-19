//
//  UIImage+XY.m
//  XYUserKit
//
//  Created by lxy on 2019/1/15.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "UIImage+XY.h"

@implementation UIImage (XY)
+(UIImage*)xy_imageWithColor:(UIColor*)color size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, CGRectMake(0, 0, size.width, size.height));
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

@end
