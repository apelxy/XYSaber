//
//  UIScrollView+XY.h
//  XYKit
//
//  Created by lxy on 2019/4/9.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^XYScrollViewPullActivityBlock)(void);


@interface UIScrollView (XY)

-(void)xy_addPullDownWithActivityHeight:(CGFloat)activityHeight animationViewHandler:(void(^)(UIView* animationView))animationViewHandler cannotActivateHandler:(void(^)(void))cannotActivateHandler canActivateHandler:(void(^)(void))canActivateHandler activityHandler:(XYScrollViewPullActivityBlock)activityHandler;
-(void)xy_beginPullDownActivity;
-(void)xy_endPullDownActivity;



-(void)xy_addPullUpWithActivityHeight:(CGFloat)activityHeight animationViewHandler:(void(^)(UIView* animationView))animationViewHandler cannotActivateHandler:(void(^)(void))cannotActivateHandler canActivateHandler:(void(^)(void))canActivateHandler  activityHandler:(XYScrollViewPullActivityBlock)activityHandler;
-(void)xy_beginPullUpActivity;
-(void)xy_endPullUpActivity;

@end


