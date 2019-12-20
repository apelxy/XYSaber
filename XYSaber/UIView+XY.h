//
//  UIView+XY.h
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XY)
@property (nonatomic,assign) CGFloat x;
@property (nonatomic,assign) CGFloat y;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;
@property (nonatomic,assign) CGFloat midX;
@property (nonatomic,assign) CGFloat midY;
@property (nonatomic,assign) CGFloat maxX;
@property (nonatomic,assign) CGFloat maxY;

@property (nonatomic,assign) CGFloat cornerRadius;
@property (nonatomic,assign) CGFloat borderWidth;
@property (nonatomic,strong) UIColor *borderColor;

@property (nonatomic,copy) void(^click)(void);

-(void)xy_removeAllSubViews;

-(void)xy_setMulCornerWithRadius:(CGFloat)radius corners:(UIRectCorner)corners;

-(void)xy_topConstraintToSuperWithConstraintValue:(CGFloat)constraintValue;
-(void)xy_bottomConstraintToSuperWithConstraintValue:(CGFloat)constraintValue;
-(void)xy_leftConstraintToSuperWithConstraintValue:(CGFloat)constraintValue;
-(void)xy_rightConstraintToSuperWithConstraintValue:(CGFloat)constraintValue;

-(void)xy_topConstraintToObjectBottom:(UIView*)objectView constraintValue:(CGFloat)constraintValue;
-(void)xy_bottomConstraintToObjectTop:(UIView*)objectView constraintValue:(CGFloat)constraintValue;
-(void)xy_leftConstraintToObjectRight:(UIView*)objectView constraintValue:(CGFloat)constraintValue;
-(void)xy_rightConstraintToObjectLeft:(UIView*)objectView constraintValue:(CGFloat)constraintValue;

-(void)xy_transformAngle:(CGFloat)angle;

@end


