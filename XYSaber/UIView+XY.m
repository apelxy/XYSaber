//
//  UIView+XY.m
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "UIView+XY.h"
#import <objc/runtime.h>
#import "XYHint.h"
#import "NSObject+XY.h"
#import "XYViewSupport.h"



static NSString *xy_topConstraintToObjectBottom_id = @"0";
static NSString *xy_bottomConstraintToObjectTop_id = @"0";
static NSString *xy_leftConstraintToObjectRight_id = @"0";
static NSString *xy_rightConstraintToObjectLeft_id = @"0";

static NSString *xy_topConstraintToSuper_id = @"0";
static NSString *xy_bottomConstraintToSuper_id = @"0";
static NSString *xy_leftConstraintToSuper_id = @"0";
static NSString *xy_rightConstraintToSuper_id = @"0";

static XYViewSupport *viewSupport_id = nil;



@interface UIView ()
@property (nonatomic,strong) XYViewSupport *viewSupport;
@end

@implementation UIView (XY)
-(void)setWidth:(CGFloat)width{

    [self judgeFrameZero];
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), width, CGRectGetHeight(self.frame));
}
-(CGFloat)width{

    return CGRectGetWidth(self.frame);
}



-(void)setHeight:(CGFloat)height{

    [self judgeFrameZero];
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), height);
}
-(CGFloat)height{

    return CGRectGetHeight(self.frame);
}



-(void)setX:(CGFloat)x{

    [self judgeFrameZero];
    self.frame = CGRectMake(x, CGRectGetMinY(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
-(CGFloat)x{

    return CGRectGetMinX(self.frame);
}



-(void)setY:(CGFloat)y{

    [self judgeFrameZero];
    self.frame = CGRectMake(CGRectGetMinX(self.frame), y , CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
-(CGFloat)y{

    return CGRectGetMinY(self.frame);
}



-(void)setMidX:(CGFloat)midX{

    [self judgeFrameZero];
    self.frame = CGRectMake(midX - CGRectGetWidth(self.frame) / 2, CGRectGetMinY(self.frame) , CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
-(CGFloat)midX{

    return CGRectGetMidX(self.frame);
}



-(void)setMidY:(CGFloat)midY{

    [self judgeFrameZero];
    self.frame = CGRectMake(CGRectGetMinX(self.frame), midY - CGRectGetHeight(self.frame) / 2, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
-(CGFloat)midY{

    return CGRectGetMidY(self.frame);
}




-(void)setMaxX:(CGFloat)maxX{

    [self judgeFrameZero];
    self.frame = CGRectMake(maxX - CGRectGetWidth(self.frame), CGRectGetMinY(self.frame) , CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
-(CGFloat)maxX{

    return CGRectGetMaxX(self.frame);
}



-(void)setMaxY:(CGFloat)maxY{

    [self judgeFrameZero];
    self.frame = CGRectMake(CGRectGetMinX(self.frame), maxY - CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}
-(CGFloat)maxY{

    return CGRectGetMaxY(self.frame);
}



-(void)judgeFrameZero{

    if(CGRectEqualToRect(self.frame, CGRectZero)){
        self.frame = CGRectMake(0, 0, 0, 0);
    }
    
}

-(void)xy_removeAllSubViews{

    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}


//圆角
static NSString *cornerRadius_id = nil;
-(void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.cornerRadius = cornerRadius;
    NSString *cornerRadiusString = [NSString stringWithFormat:@"%f",cornerRadius];
    objc_setAssociatedObject(self, &cornerRadius_id, cornerRadiusString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGFloat)cornerRadius{
    return [objc_getAssociatedObject(self, &cornerRadius_id)floatValue];
}


//边框宽度
static NSString *borderWidth_id = nil;
-(void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
    NSString *borderWidthString = [NSString stringWithFormat:@"%f",borderWidth];
    objc_setAssociatedObject(self, &borderWidth_id, borderWidthString, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGFloat)borderWidth{
    return [objc_getAssociatedObject(self, &borderWidth_id)floatValue];
}

//边框颜色
static UIColor *borderColor_id = nil;
-(void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
    objc_setAssociatedObject(self, &borderColor_id, borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIColor*)borderColor{
    return objc_getAssociatedObject(self, &borderColor_id);
}


//显示提示信息
-(void)xy_showMsg:(NSString*)msg endTime:(NSInteger)endTime{
    
    XYHint *hint = [[XYHint alloc]initWithView:self loading:NO];
    hint.text = msg;
    hint.endTime = endTime;
    [hint show];
}

-(void)xy_setMulCornerWithRadius:(CGFloat)radius corners:(UIRectCorner)corners{
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
}


#pragma mark UIView点击事件
-(void)setViewSupport:(XYViewSupport *)viewSupport{
    objc_setAssociatedObject(self, &viewSupport_id, viewSupport, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(XYViewSupport*)viewSupport{
    XYViewSupport *support = objc_getAssociatedObject(self, &viewSupport_id);
    if (!support) {
        support = [[XYViewSupport alloc]init];
        [self setViewSupport:support];
    }
    return support;
}
//点击手势
-(void)setClick:(void (^)(void))click{
    self.viewSupport.click = click;
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self.viewSupport action:@selector(blViewAction:)];
    [self addGestureRecognizer:ges];
}


#pragma mark frame父视图约束
-(void)xy_topConstraintToSuperWithConstraintValue:(CGFloat)constraintValue{
    
    if ([objc_getAssociatedObject(self, &xy_bottomConstraintToSuper_id)integerValue]) {
        CGFloat newY = 0 + constraintValue;
        self.height = self.maxY - newY;
        self.y = newY;
    }else{
        self.y = 0 + constraintValue;
    }
    
    objc_setAssociatedObject(self, &xy_topConstraintToSuper_id, @"1", OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.superview xy_addObserveWithKeyPath:@"frame" options:NSKeyValueObservingOptionNew handler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if ([objc_getAssociatedObject(self, &xy_bottomConstraintToSuper_id)integerValue]) {
            CGFloat newY = 0 + constraintValue;
            self.height = self.maxY - newY;
            self.y = newY;
        }else{
            self.y = 0 + constraintValue;
        }
    }];
}
-(void)xy_bottomConstraintToSuperWithConstraintValue:(CGFloat)constraintValue{
    
    if ([objc_getAssociatedObject(self, &xy_topConstraintToSuper_id)integerValue]) {
        CGFloat newMaxY = self.superview.height - constraintValue;
        self.height = newMaxY - self.y;
        self.maxY = newMaxY;
    }else{
        self.maxY = self.superview.height - constraintValue;
    }
    
    objc_setAssociatedObject(self, &xy_bottomConstraintToSuper_id, @"1", OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.superview xy_addObserveWithKeyPath:@"frame" options:NSKeyValueObservingOptionNew handler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if ([objc_getAssociatedObject(self, &xy_topConstraintToSuper_id)integerValue]) {
            CGFloat newMaxY = self.superview.height - constraintValue;
            self.height = newMaxY - self.y;
            self.maxY = newMaxY;
        }else{
            self.maxY = self.superview.height - constraintValue;
        }
    }];
}
-(void)xy_leftConstraintToSuperWithConstraintValue:(CGFloat)constraintValue{
    
    if ([objc_getAssociatedObject(self, &xy_rightConstraintToSuper_id)integerValue]) {
        CGFloat newX = 0 + constraintValue;
        self.width = self.maxX - newX;
        self.x = newX;
    }else{
        self.x = 0 + constraintValue;
    }
    
    objc_setAssociatedObject(self, &xy_leftConstraintToSuper_id, @"1", OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.superview xy_addObserveWithKeyPath:@"frame" options:NSKeyValueObservingOptionNew handler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if ([objc_getAssociatedObject(self, &xy_rightConstraintToSuper_id)integerValue]) {
            CGFloat newX = 0 + constraintValue;
            self.width = self.maxX - newX;
            self.x = newX;
        }else{
            self.x = 0 + constraintValue;
        }
    }];
}
-(void)xy_rightConstraintToSuperWithConstraintValue:(CGFloat)constraintValue{
    
    if ([objc_getAssociatedObject(self, &xy_leftConstraintToSuper_id)integerValue]) {
        CGFloat newMaxX = self.superview.width - constraintValue;
        self.width = newMaxX - self.x;
        self.maxX = newMaxX;
    }else{
        self.maxX = self.superview.width - constraintValue;
    }
    
    objc_setAssociatedObject(self, &xy_rightConstraintToSuper_id, @"1", OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self.superview xy_addObserveWithKeyPath:@"frame" options:NSKeyValueObservingOptionNew handler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if ([objc_getAssociatedObject(self, &xy_leftConstraintToSuper_id)integerValue]) {
            CGFloat newMaxX = self.superview.width - constraintValue;
            self.width = newMaxX - self.x;
            self.maxX = newMaxX;
        }else{
            self.maxX = self.superview.width - constraintValue;
        }
    }];
}
#pragma mark frame兄视图约束
-(void)xy_topConstraintToObjectBottom:(UIView*)objectView constraintValue:(CGFloat)constraintValue{
    
    if ([objc_getAssociatedObject(self, &xy_bottomConstraintToObjectTop_id)integerValue]) {
        CGFloat newY = objectView.maxY + constraintValue;
        self.height = self.maxY - newY;
        self.y = newY;
    }else{
        self.y = objectView.maxY + constraintValue;
    }
    
    objc_setAssociatedObject(self, &xy_topConstraintToObjectBottom_id, @"1", OBJC_ASSOCIATION_COPY_NONATOMIC);
    [objectView xy_addObserveWithKeyPath:@"frame" options:NSKeyValueObservingOptionNew handler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if ([objc_getAssociatedObject(self, &xy_bottomConstraintToObjectTop_id)integerValue]) {
            CGFloat newY = objectView.maxY + constraintValue;
            self.height = self.maxY - newY;
            self.y = newY;
        }else{
            self.y = objectView.maxY + constraintValue;
        }
    }];
}
-(void)xy_bottomConstraintToObjectTop:(UIView*)objectView constraintValue:(CGFloat)constraintValue{
    
    if ([objc_getAssociatedObject(self,&xy_topConstraintToObjectBottom_id)integerValue]) {
        CGFloat newMaxY = objectView.y - constraintValue;
        self.height = newMaxY - self.y;
        self.maxY = newMaxY;
    }else{
        self.maxY = objectView.y - constraintValue;
    }
    self.maxY = objectView.y - constraintValue;
    objc_setAssociatedObject(self, &xy_bottomConstraintToObjectTop_id, @"1", OBJC_ASSOCIATION_COPY_NONATOMIC);
    [objectView xy_addObserveWithKeyPath:@"frame" options:NSKeyValueObservingOptionNew handler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if ([objc_getAssociatedObject(self,&xy_topConstraintToObjectBottom_id)integerValue]) {
            CGFloat newMaxY = objectView.y - constraintValue;
            self.height = newMaxY - self.y;
            self.maxY = newMaxY;
        }else{
            self.maxY = objectView.y - constraintValue;
        }
    }];
}
-(void)xy_leftConstraintToObjectRight:(UIView*)objectView constraintValue:(CGFloat)constraintValue{
    
    if ([objc_getAssociatedObject(self, &xy_rightConstraintToObjectLeft_id)integerValue]) {
        CGFloat newX = objectView.maxX + constraintValue;
        self.width = self.maxX - newX;
        self.x = newX;
    }else{
        self.x = objectView.maxX + constraintValue;
    }
    
    objc_setAssociatedObject(self, &xy_leftConstraintToObjectRight_id, @"1", OBJC_ASSOCIATION_COPY_NONATOMIC);
    [objectView xy_addObserveWithKeyPath:@"frame" options:NSKeyValueObservingOptionNew handler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if ([objc_getAssociatedObject(self, &xy_rightConstraintToObjectLeft_id)integerValue]) {
            CGFloat newX = objectView.maxX + constraintValue;
            self.width = self.maxX - newX;
            self.x = newX;
        }else{
            self.x = objectView.maxX + constraintValue;
        }
    }];
}
-(void)xy_rightConstraintToObjectLeft:(UIView*)objectView constraintValue:(CGFloat)constraintValue{
    
    if ([objc_getAssociatedObject(self, &xy_leftConstraintToObjectRight_id)integerValue]) {
        CGFloat newMaxX = objectView.x - constraintValue;
        self.width = newMaxX - self.x;
        self.maxX = newMaxX;
    }else{
        self.maxX = objectView.x - constraintValue;
    }
    
    objc_setAssociatedObject(self, &xy_rightConstraintToObjectLeft_id, @"1", OBJC_ASSOCIATION_COPY_NONATOMIC);
    [objectView xy_addObserveWithKeyPath:@"frame" options:NSKeyValueObservingOptionNew handler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        if ([objc_getAssociatedObject(self, &xy_leftConstraintToObjectRight_id)integerValue]) {
            CGFloat newMaxX = objectView.x - constraintValue;
            self.width = newMaxX - self.x;
            self.maxX = newMaxX;
        }else{
            self.maxX = objectView.x - constraintValue;
        }
    }];
}

//旋转角度
-(void)xy_transformAngle:(CGFloat)angle{
    self.transform = CGAffineTransformMakeRotation(M_PI * angle / 180);
}


@end
