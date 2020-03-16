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

#define UITableViewCellLeftSwipeOtherCellSwipeNotification @"UITableViewCellLeftSwipeOtherCellSwipeNotification"

@interface UITableViewCell ()<UIGestureRecognizerDelegate>
@property (nonatomic,strong) UIView *coverView;
@property (nonatomic,strong) UIPanGestureRecognizer *swipeGes;
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
//coverView
static UIView *coverView_id = nil;
-(void)setCoverView:(UIView *)coverView{
    objc_setAssociatedObject(self, &coverView_id, coverView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView*)coverView{
    return objc_getAssociatedObject(self, &coverView_id);
}
//swipeGes
static UIPanGestureRecognizer *swipeGes_id = nil;
-(void)setSwipeGes:(UIPanGestureRecognizer *)swipeGes{
    objc_setAssociatedObject(self, &swipeGes_id, swipeGes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIPanGestureRecognizer*)swipeGes{
    return objc_getAssociatedObject(self, &swipeGes_id);
}
//添加左滑编辑功能
-(void)xy_addLeftSwipeWithView:(UIView*)diyView cellWidth:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight{
    setWeakSelf
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self xy_removeLeftSwipe];//先移除旧的

    self.leftSwipeCellWidth = cellWidth;
    self.leftSwipeCellHeight = cellHeight;

    self.coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, cellWidth, cellHeight)];
    self.coverView.hidden = YES;
    self.coverView.click = ^{
        [weakSelf xy_hideLeftSwipe];
    };
    [self.contentView addSubview:self.coverView];
    
    self.swipeGes = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(swipeGesAct:)];
    self.swipeGes.delegate = self;
    [self.contentView addGestureRecognizer:self.swipeGes];
    
    
    //左滑漏出的视图
    self.diyView = diyView;
    diyView.maxX = self.leftSwipeCellWidth;
    [self insertSubview:diyView belowSubview:self.contentView];
    
    //接收其他cell左滑通知后取消本cell的左滑状态
    [self xy_addObserveWithName:UITableViewCellLeftSwipeOtherCellSwipeNotification activate:^(NSNotification * _Nonnull notification) {
        UITableViewCell *cell = notification.object;
        if (cell != self) {
            [weakSelf xy_hideLeftSwipe];
        }
    }];
}

-(void)swipeGesAct:(UIPanGestureRecognizer*)ges{
    if (ges.state == UIGestureRecognizerStateBegan) {
        self.backViewPoint = [ges locationInView:self.contentView];
        //发送左滑通知
        [[NSNotificationCenter defaultCenter]postNotificationName:UITableViewCellLeftSwipeOtherCellSwipeNotification object:nil];
    }else if (ges.state == UIGestureRecognizerStateChanged){
        CGPoint point = [ges locationInView:self];
        CGFloat differenceX= point.x - self.backViewPoint.x;
        CGFloat newX = 0 + differenceX;
        self.contentView.x = newX;
        if (newX < -self.diyView.width) {
            self.contentView.x = 0 - self.diyView.width;
        }else if (newX > 0){
            self.contentView.x = 0;
        }
    }else if (ges.state == UIGestureRecognizerStateEnded){
        if (self.contentView.maxX < self.leftSwipeCellWidth - self.diyView.width / 2) {
            [UIView animateWithDuration:.1 animations:^{
                self.coverView.hidden = NO;
                self.contentView.x = 0 - self.diyView.width;
            }];
        }else{
            [UIView animateWithDuration:.1 animations:^{
                self.contentView.x = 0;

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
-(void)xy_hideLeftSwipe{
    self.coverView.hidden = YES;
    [UIView animateWithDuration:.3 animations:^{
        self.contentView.x = 0;
    }];
}

//移除左滑编辑功能
-(void)xy_removeLeftSwipe{
    
    self.contentView.x = 0;
    [self.diyView removeFromSuperview];
    self.backViewPoint = CGPointZero;
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITableViewCellLeftSwipeOtherCellSwipeNotification object:nil];
    [self.contentView removeGestureRecognizer:self.swipeGes];
    
}

@end
