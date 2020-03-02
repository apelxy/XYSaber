//
//  UIButton+XY.m
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "UIButton+XY.h"
#import <objc/runtime.h>
#import "XYButtonSupport.h"

static XYButtonSupport *support_id = nil;

@interface UIButton ()
@property (nonatomic,strong) XYButtonSupport *support;

@end

@implementation UIButton (XY)
-(void)setSupport:(XYButtonSupport *)support{
    objc_setAssociatedObject(self, &support_id, support, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(XYButtonSupport*)support{
    XYButtonSupport *support = objc_getAssociatedObject(self, &support_id);
    if (!support) {
        support = [[XYButtonSupport alloc]init];
        [self setSupport:support];
    }
    return support;
}

//action
-(void)setAction:(void (^)(UIButton *))action{
    self.support.action = action;
    [self addTarget:self.support action:@selector(targetAct:) forControlEvents:UIControlEventTouchUpInside];
}

//字体适配button宽度
-(void)xy_contentFitToWith{
    
    CGFloat fontNumber = self.titleLabel.font.pointSize;
    NSString *fontName = self.titleLabel.font.fontName;
    for (CGFloat num = fontNumber; num > 0; num = num - 0.5) {
        UIFont *font = [UIFont fontWithName:fontName size:num];
        CGSize size = [self.titleLabel.text sizeWithFont:font];
        if (size.width <= CGRectGetWidth(self.frame)) {
            self.titleLabel.font = font;
            break;
        }
    }
}



@end
