//
//  UILabel+XY.m
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "UILabel+XY.h"
#import "UIView+XY.h"

@implementation UILabel (XY)
-(void)xy_contentFitToWidth{
    
    CGFloat fontNumber = self.font.pointSize;
    for (CGFloat num = fontNumber; num > 0; num = num - 0.5) {
        UIFont *font = [UIFont systemFontOfSize:num];
        CGSize size = [self.text sizeWithFont:font];
        if (size.width <= CGRectGetWidth(self.frame)) {
            self.font = font;
            break;
        }
    }
}


@end
