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

static NSString *title_id = nil;
static UIColor *titleColor_id = nil;
static UIImage *image_id = nil;
static UIImage *backgroundImage_id = nil;
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
//标题
-(void)setTitle:(NSString *)title{
    [self setTitle:title forState:UIControlStateNormal];
    objc_setAssociatedObject(self, &title_id, title, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString*)title{
    return objc_getAssociatedObject(self, &title_id);
}

//标题颜色
-(void)setTitleColor:(UIColor *)titleColor{
    [self setTitleColor:titleColor forState:UIControlStateNormal];
    objc_setAssociatedObject(self, &titleColor_id, titleColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIColor*)titleColor{
    return objc_getAssociatedObject(self, &titleColor_id);
}

//图片
-(void)setImage:(UIImage *)image{
    [self setImage:image forState:UIControlStateNormal];
    objc_setAssociatedObject(self, &image_id, image, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//背景图
-(void)setBackgroundImage:(UIImage *)backgroundImage{
    [self setBackgroundImage:backgroundImage forState:UIControlStateNormal];
    objc_setAssociatedObject(self, &backgroundImage_id, backgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
