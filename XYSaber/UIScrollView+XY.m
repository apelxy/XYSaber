//
//  UIScrollView+XY.m
//  XYKit
//
//  Created by lxy on 2019/4/9.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "UIScrollView+XY.h"
#import "NSObject+XY.h"
#import <objc/runtime.h>
#import "XYApp.h"
#import "XYMacro.h"
#import "UIView+XY.h"
#import "UILabel+XY.h"
#import "UIGestureRecognizer+XY.h"
@interface UIScrollView ()<UIGestureRecognizerDelegate>

@property (nonatomic,assign) CGFloat pullDownActivityHeight;
@property (nonatomic,copy) XYScrollViewPullActivityBlock pullDownActivityHandler;
@property (nonatomic,strong) UIActivityIndicatorView *topIndicatorView;
@property (nonatomic,strong) UILabel *topLabel;



@property (nonatomic,assign) CGFloat pullUpActivityHeight;
@property (nonatomic,copy) XYScrollViewPullActivityBlock pullUpActivityHandler;
@property (nonatomic,strong) UIView *bottomView;
@property (nonatomic,strong) UIView *bottomUserAnimationView;
@property (nonatomic,strong) UIActivityIndicatorView *bottomIndicatorView;
@property (nonatomic,strong) UILabel *bottomLabel;


@end


static NSString *pullDownActivityHeight_id = nil;
static XYScrollViewPullActivityBlock pullDownActivityHandler_id = nil;
static UIActivityIndicatorView *topIndicatorView_id = nil;
static UILabel *topLabel_id = nil;
static NSString *pullDownActivited_id = nil;



static NSString *pullUpActivityHeight_id = nil;
static XYScrollViewPullActivityBlock pullUpActivityHandler_id = nil;
static UIView *bottomView_id = nil;
static UIView *bottomUserAnimationView_id = nil;
static UIActivityIndicatorView *bottomIndicatorView_id = nil;
static UILabel *bottomLabel_id = nil;
static NSString *pullUpActivited_id = nil;

@implementation UIScrollView (XY)

#pragma mark 下拉刷新========================================================================
-(void)setPullDownActivityHeight:(CGFloat)pullDownActivityHeight{
    objc_setAssociatedObject(self, &pullDownActivityHeight_id, [NSString stringWithFormat:@"%f",pullDownActivityHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGFloat)pullDownActivityHeight{
    return [objc_getAssociatedObject(self, &pullDownActivityHeight_id)floatValue];
}

-(void)setPullDownActivityHandler:(XYScrollViewPullActivityBlock)pullDownActivityHandler{
    objc_setAssociatedObject(self, &pullDownActivityHandler_id, pullDownActivityHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(XYScrollViewPullActivityBlock)pullDownActivityHandler{
    return objc_getAssociatedObject(self, &pullDownActivityHandler_id);
}


-(UIActivityIndicatorView*)topIndicatorView{
    UIActivityIndicatorView *indicatorView = objc_getAssociatedObject(self, &topIndicatorView_id);
    if (!indicatorView) {
        indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        indicatorView.maxX = self.width / 2 - 30;
        indicatorView.maxY = 70;
        indicatorView.color = [UIColor grayColor];
        indicatorView.hidesWhenStopped = NO;
        objc_setAssociatedObject(self, &topIndicatorView_id, indicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return indicatorView;
}
-(UILabel*)topLabel{
    UILabel *label = objc_getAssociatedObject(self, &topLabel_id);
    if (!label) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 40)];
        label.x = self.topIndicatorView.maxX;
        label.midY = self.topIndicatorView.midY;
        label.textColor = [UIColor grayColor];
        label.text = @"正在刷新...";
        [label xy_contentFitToWidth];
        label.text = @"松开开始刷新";
        [label xy_contentFitToWidth];
        
        objc_setAssociatedObject(self, &topLabel_id, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}

-(UIView*)getPullDownTopView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, -80, self.frame.size.width, 80)];
    [topView addSubview:self.topIndicatorView];
    [topView addSubview:self.topLabel];
    return topView;
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)otherGestureRecognizer{
    
    if (![gestureRecognizer.tag isEqualToString:@"UIPanGestureRecognizer_pullDown"] && ![gestureRecognizer.tag isEqualToString:@"UIPanGestureRecognizer_pullUp"]) {
        return NO;
    }
    if ([gestureRecognizer.view isKindOfClass:[UIScrollView class]]) {
        return YES;
    }else{
        return NO;
    }
}
-(void)xy_addPullDownWithActivityHeight:(CGFloat)activityHeight animationViewHandler:(void(^)(UIView* animationView))animationViewHandler cannotActivateHandler:(void(^)(void))cannotActivateHandler canActivateHandler:(void(^)(void))canActivateHandler activityHandler:(XYScrollViewPullActivityBlock)activityHandler{
    
    UIView *userAnimationView = [[UIView alloc]initWithFrame:CGRectMake(0, -activityHeight, self.width, activityHeight)];
    if (animationViewHandler) {
        animationViewHandler(userAnimationView);
        [self addSubview:userAnimationView];
    }else{
        [self addSubview:[self getPullDownTopView]];
    }
    
    
    self.pullDownActivityHeight = activityHeight;
    self.pullDownActivityHandler = activityHandler;
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pullDownGes:)];
    panGes.delegate = self;
    panGes.tag = @"UIPanGestureRecognizer_pullDown";
    [self addGestureRecognizer:panGes];
    
    setWeakSelf
    [self xy_addObserveWithKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew handler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        NSValue *pointValue = change[@"new"];
        CGPoint point = pointValue.CGPointValue;
        
        
        if (point.y < 0 && ![objc_getAssociatedObject(weakSelf, &pullDownActivited_id)integerValue]) {

            if (point.y >= 0-self.pullDownActivityHeight) {
                weakSelf.topLabel.text = @"下拉刷新";
                cannotActivateHandler();
            }else{
                weakSelf.topLabel.text = @"松开开始刷新";
                canActivateHandler();
            }
        }
    }];
}



-(void)pullDownGes:(UIGestureRecognizer*)ges{
    if (ges.state == UIGestureRecognizerStateEnded) {
        CGFloat realOffSetY = self.contentOffset.y;
        if (realOffSetY < (0 - self.pullDownActivityHeight)) {
            [self xy_beginPullDownActivity];
        }
    }else if (ges.state == UIGestureRecognizerStateBegan){
        
    }
}

-(void)xy_beginPullDownActivity{
    if (!self.pullDownActivityHandler) {
        return;
    }
    
    [self.topIndicatorView startAnimating];//开始转动
    self.topLabel.text = @"正在刷新...";
    objc_setAssociatedObject(self, &pullDownActivited_id, @"1", OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    self.pullDownActivityHandler();
    [UIView animateWithDuration:.2 animations:^{
        self.contentInset = UIEdgeInsetsMake(self.pullDownActivityHeight - 20, 0, 0, 0);
        [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    }];
}

-(void)xy_endPullDownActivity{
    
    objc_setAssociatedObject(self, &pullDownActivited_id, @"0", OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [UIView animateWithDuration:.2 animations:^{
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
        [self.topIndicatorView stopAnimating];//停止转动
        self.topLabel.text = @"下拉刷新";
    }];
}



#pragma mark 上拉刷新========================================================================
-(void)setPullUpActivityHeight:(CGFloat)pullUpActivityHeight{
    objc_setAssociatedObject(self, &pullUpActivityHeight_id, [NSString stringWithFormat:@"%f",pullUpActivityHeight], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGFloat)pullUpActivityHeight{
    return [objc_getAssociatedObject(self, &pullUpActivityHeight_id)floatValue];
}
-(void)setPullUpActivityHandler:(XYScrollViewPullActivityBlock)pullUpActivityHandler{
    objc_setAssociatedObject(self, &pullUpActivityHandler_id, pullUpActivityHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(XYScrollViewPullActivityBlock)pullUpActivityHandler{
    return objc_getAssociatedObject(self, &pullUpActivityHandler_id);
}
-(void)setBottomUserAnimationView:(UIView *)bottomUserAnimationView{
    objc_setAssociatedObject(self, &bottomUserAnimationView_id, bottomUserAnimationView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView*)bottomUserAnimationView{
    return objc_getAssociatedObject(self, &bottomUserAnimationView_id);
}
-(UIActivityIndicatorView*)bottomIndicatorView{
    UIActivityIndicatorView *indicatorView = objc_getAssociatedObject(self, &bottomIndicatorView_id);
    if (!indicatorView) {
        indicatorView = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        indicatorView.maxX = self.width / 2 - 30;
        indicatorView.y = 10;
        indicatorView.color = [UIColor grayColor];
        indicatorView.hidesWhenStopped = NO;
        objc_setAssociatedObject(self, &bottomIndicatorView_id, indicatorView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return indicatorView;
}
-(UILabel*)bottomLabel{
    UILabel *label = objc_getAssociatedObject(self, &bottomLabel_id);
    if (!label) {
        label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 40)];
        label.x = self.bottomIndicatorView.maxX;
        label.midY = self.bottomIndicatorView.midY;
        label.textColor = [UIColor grayColor];
        label.text = @"正在刷新...";
        [label xy_contentFitToWidth];
        label.text = @"松开开始刷新";
        [label xy_contentFitToWidth];
        
        objc_setAssociatedObject(self, &bottomLabel_id, label, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return label;
}
-(UIView*)bottomView{
    UIView *bottomView = objc_getAssociatedObject(self, &bottomView_id);
    if (!bottomView) {
        bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, MAXFLOAT, self.frame.size.width, 80)];
        [bottomView addSubview:self.bottomIndicatorView];
        [bottomView addSubview:self.bottomLabel];
//        bottomView.backgroundColor = [UIColor cyanColor];
        
        objc_setAssociatedObject(self, &bottomView_id, bottomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return bottomView;
}


-(void)xy_addPullUpWithActivityHeight:(CGFloat)activityHeight animationViewHandler:(void(^)(UIView* animationView))animationViewHandler cannotActivateHandler:(void(^)(void))cannotActivateHandler canActivateHandler:(void(^)(void))canActivateHandler  activityHandler:(XYScrollViewPullActivityBlock)activityHandler{
    
    self.bottomUserAnimationView = [[UIView alloc]initWithFrame:CGRectMake(0, MAXFLOAT, self.width, activityHeight)];
    if (animationViewHandler) {
        animationViewHandler(self.bottomUserAnimationView);
        [self addSubview:self.bottomUserAnimationView];
    }else{
        [self addSubview:[self bottomView]];
    }
    
    
    self.pullUpActivityHeight = activityHeight;
    self.pullUpActivityHandler = activityHandler;
    
    UIPanGestureRecognizer *panGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(pullUpGes:)];
    panGes.delegate = self;
    panGes.tag = @"UIPanGestureRecognizer_pullUp";
    [self addGestureRecognizer:panGes];
    
    setWeakSelf
    [self xy_addObserveWithKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew handler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nonnull change) {
        NSValue *pointValue = change[@"new"];
        CGPoint point = pointValue.CGPointValue;

        if (point.y > self.contentSize.height - self.height && ![objc_getAssociatedObject(weakSelf, &pullUpActivited_id)integerValue]) {
            
            if (point.y <= self.contentSize.height - self.height + self.pullUpActivityHeight) {
                weakSelf.bottomLabel.text = @"上拉刷新";
                cannotActivateHandler();
            }else{
                weakSelf.bottomLabel.text = @"松开开始刷新";
                canActivateHandler();
            }
        }
    }];
}
-(void)pullUpGes:(UIGestureRecognizer*)ges{
    if (ges.state == UIGestureRecognizerStateEnded) {
        CGFloat realOffSetY = self.contentOffset.y;
        if(realOffSetY > (self.contentSize.height - self.height) + self.pullUpActivityHeight){
            [self xy_beginPullUpActivity];
        }
    }else if (ges.state == UIGestureRecognizerStateBegan){
        
    }
    self.bottomView.y = self.contentSize.height;
    self.bottomUserAnimationView.y = self.contentSize.height;
}
-(void)xy_beginPullUpActivity{
    if (!self.pullUpActivityHandler) {
        return;
    }
    self.bottomView.y = self.contentSize.height;
    self.bottomUserAnimationView.y = self.contentSize.height;
    
    [self.bottomIndicatorView startAnimating];//开始转动
    self.bottomLabel.text = @"正在刷新...";
    objc_setAssociatedObject(self, &pullUpActivited_id, @"1", OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    self.pullUpActivityHandler();
    [UIView animateWithDuration:.2 animations:^{
        self.contentInset = UIEdgeInsetsMake(0, 0, self.pullUpActivityHeight, 0);
        [self scrollRectToVisible:CGRectMake(0, self.contentSize.height, 1, 1) animated:NO];
    }];
}

-(void)xy_endPullUpActivity{
    
    objc_setAssociatedObject(self, &pullUpActivited_id, @"0", OBJC_ASSOCIATION_COPY_NONATOMIC);
    
    [UIView animateWithDuration:.2 animations:^{
        self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        self.userInteractionEnabled = YES;
        [self.bottomIndicatorView stopAnimating];//停止转动
        self.bottomLabel.text = @"下拉刷新";
    }];
}
@end
