//
//  UITableViewCell+XY.m
//  XYUserTool
//
//  Created by lxy on 2019/1/11.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "UITableViewCell+XY.h"
#import <objc/runtime.h>
#import "XYMacro.h"
#import "UIView+XY.h"
#import "NSObject+XY.h"

@interface SlideBackView : UIView
@end
@implementation SlideBackView
@end



#pragma mark ---------------------------------------------------------------------------------------

@interface UITableViewCell ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) SlideBackView *backView;
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,assign) CGPoint backViewPoint;
@property (nonatomic,assign) UIView *diyView;
@property (nonatomic,assign) CGFloat leftSwipeCellWidth;
@property (nonatomic,assign) CGFloat leftSwipeCellHeight;
@end


@implementation UITableViewCell (XY)
//dataBlock
static XYTableViewCellTransBlock dataBlock_id = nil;
-(void)setDataBlock:(XYTableViewCellTransBlock)dataBlock{
    objc_setAssociatedObject(self, &dataBlock_id, dataBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(XYTableViewCellTransBlock)dataBlock{
    return objc_getAssociatedObject(self, &dataBlock_id);
}
//backBlock
static XYTableViewCellTransBlock backBlock_id = nil;
-(void)setBackBlock:(XYTableViewCellTransBlock)backBlock{
    objc_setAssociatedObject(self, &backBlock_id, backBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(XYTableViewCellTransBlock)backBlock{
    return objc_getAssociatedObject(self, &backBlock_id);
}
//高度
static NSString *height_id = nil;
-(void)setHeight:(CGFloat)height{
    objc_setAssociatedObject(self, &height_id, [NSString stringWithFormat:@"%f",height], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGFloat)height{
    return [objc_getAssociatedObject(self, &height_id)floatValue];
}
//宽度
static NSString *width_id = nil;
-(void)setWidth:(CGFloat)width{
    objc_setAssociatedObject(self, &width_id, [NSString stringWithFormat:@"%f",width], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGFloat)width{
    return [objc_getAssociatedObject(self, &width_id)floatValue];
}
//backViewPoint
static NSString *backViewPointX_id = nil;
static NSString *backViewPointY_id = nil;
-(void)setBackViewPoint:(CGPoint)backViewPoint{
    objc_setAssociatedObject(self, &backViewPointX_id, NSStringFromFloat(backViewPoint.x), OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_setAssociatedObject(self, &backViewPointY_id, NSStringFromFloat(backViewPoint.y), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGPoint)backViewPoint{
    return CGPointMake([objc_getAssociatedObject(self, &backViewPointX_id)floatValue], [objc_getAssociatedObject(self, &backViewPointY_id)floatValue]);
}
//backView
static SlideBackView *backView_id = nil;
-(void)setBackView:(SlideBackView *)backView{
    objc_setAssociatedObject(self, &backView_id, backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(SlideBackView*)backView{
    return objc_getAssociatedObject(self, &backView_id);
}
//backView
static UIView *coverView_id = nil;
-(void)setCoverView:(UIView *)coverView{
    objc_setAssociatedObject(self, &coverView_id, coverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView*)coverView{
    return objc_getAssociatedObject(self, &coverView_id);
}
//diyView
static UIView *diyView_id = nil;
-(void)setDiyView:(UIView *)diyView{
    objc_setAssociatedObject(self, &diyView_id, diyView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView*)diyView{
    return objc_getAssociatedObject(self, &diyView_id);
}
//leftSwipeCellWidth
static NSString *leftSwipeCellWidth_id = nil;
-(void)setLeftSwipeCellWidth:(CGFloat)leftSwipeCellWidth{
    objc_setAssociatedObject(self, &leftSwipeCellWidth_id, NSStringFromFloat(leftSwipeCellWidth), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGFloat)leftSwipeCellWidth{
    return [objc_getAssociatedObject(self, &leftSwipeCellWidth_id)floatValue];
}
//leftSwipeCellHeight
static NSString *leftSwipeCellHeight_id = nil;
-(void)setLeftSwipeCellHeight:(CGFloat)leftSwipeCellHeight{
    objc_setAssociatedObject(self, &leftSwipeCellHeight_id, NSStringFromFloat(leftSwipeCellHeight), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGFloat)leftSwipeCellHeight{
    return [objc_getAssociatedObject(self, &leftSwipeCellHeight_id)floatValue];
}



//移除左滑编辑功能
-(void)xy_removeLeftSwipe{
    NSArray *subArray = self.backView.subviews;
    for (UIView *view in subArray) {
        [self addSubview:view];
    }
    [self.backView removeFromSuperview];
    [self.diyView removeFromSuperview];
    self.backViewPoint = CGPointZero;
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
//添加左滑编辑功能
-(void)xy_addLeftSwipeWithView:(UIView*)diyView cellWidth:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight{
    setWeakSelf
    
    [self xy_removeLeftSwipe];//先移除旧的
    
    self.leftSwipeCellWidth = cellWidth;
    self.leftSwipeCellHeight = cellHeight;
    
    self.backView = [[SlideBackView alloc]initWithFrame:CGRectMake(0, 0, self.leftSwipeCellWidth, self.leftSwipeCellHeight)];
    self.backView.backgroundColor = self.backgroundColor;
    [self addSubview:self.backView];
    
    
    UIPanGestureRecognizer *swipeGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesAct:)];
    swipeGes.delegate = self;
    [self.backView addGestureRecognizer:swipeGes];
    
    NSArray *subArray = self.subviews;
    for (UIView *view in subArray) {
        NSString *viewClassString = NSStringFromClass([view class]);
        if (![viewClassString isEqualToString:@"SlideBackView"] && ![viewClassString isEqualToString:@"UITableViewCellContentView"]) {
            [self.backView addSubview:view];
        }
    }
    
    //加盖子
    self.coverView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.backView.width - 30, self.leftSwipeCellHeight)];
//    self.coverView.backgroundColor = [[UIColor redColor]colorWithAlphaComponent:.1];
    self.coverView.hidden = YES;
    self.coverView.click = ^{
        [weakSelf hideLeftSwipe];
    };
    [self.backView addSubview:self.coverView];
    
    //左滑漏出的视图
    self.diyView = diyView;
    diyView.maxX = self.leftSwipeCellWidth;
    [self insertSubview:diyView belowSubview:self.backView];
    
    //接收左滑通知
    [self xy_addObserveWithName:@"UITableViewCellLeftSwipeNotification" activate:^(NSNotification * _Nonnull notification) {
        UITableViewCell *cell = notification.object;
        if (cell != self) {
            [weakSelf hideLeftSwipe];
        }
    }];
}

-(void)swipeGesAct:(UIGestureRecognizer*)ges{
    if (ges.state == UIGestureRecognizerStateBegan) {
        self.backViewPoint = [ges locationInView:self.backView];
        //发送左滑通知
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UITableViewCellLeftSwipeNotification" object:self];
    }else if (ges.state == UIGestureRecognizerStateChanged){
        CGPoint point = [ges locationInView:self];
        CGFloat differenceX= point.x - self.backViewPoint.x;
        CGFloat newX = 0 + differenceX;
        self.backView.x = newX;
        if (newX < -self.diyView.width) {
            self.backView.x = 0 - self.diyView.width;
        }else if (newX > 0){
            self.backView.x = 0;
        }
    }else if (ges.state == UIGestureRecognizerStateEnded){
        if (self.backView.maxX < self.leftSwipeCellWidth - self.diyView.width / 2) {
            [UIView animateWithDuration:.1 animations:^{
                self.backView.x = 0 - self.diyView.width;
                self.coverView.hidden = NO;
            }];
        }else{
            [UIView animateWithDuration:.1 animations:^{
                self.backView.x = 0;
                self.coverView.hidden = YES;
            }];
        }
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    CGPoint point = [touch locationInView:touch.view];
    if (point.x >= self.leftSwipeCellWidth - 30) {
        return YES;
    }
    return NO;
}

//收起左滑
-(void)hideLeftSwipe{
    [UIView animateWithDuration:.3 animations:^{
        self.backView.x = 0;
        self.coverView.hidden = YES;
    }];
}


@end
