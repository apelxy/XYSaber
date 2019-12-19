//
//  UIColor+XY.m
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "UIColor+XY.h"

@implementation UIColor (XY)
+(UIColor *)xy_hexColor:(NSString *)hexStr{
    NSString *str1 = [hexStr substringToIndex:2];
    NSString *str2 = [hexStr substringWithRange:NSMakeRange(2, 2)];
    NSString *str3 = [hexStr substringFromIndex:4];
    unsigned int r, g, b;
    [[NSScanner scannerWithString:str1] scanHexInt:&r];
    [[NSScanner scannerWithString:str2] scanHexInt:&g];
    [[NSScanner scannerWithString:str3] scanHexInt:&b];
    UIColor *color = [UIColor colorWithRed:((float)r/255.0f) green:((float)g/255.0f) blue:((float)b/255.0f) alpha:1];
    return color;
}
@end
