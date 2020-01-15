//
//  UITableView+Index.m
//  XYKitDemo
//
//  Created by lxy on 2019/12/23.
//  Copyright © 2019 lxy. All rights reserved.
//

#import "UITableView+IndexView.h"
#import <objc/runtime.h>

typedef void(^ActionHandler)(NSInteger index);

@interface UITableView ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) CGFloat defaultContentOffSet;
@property (nonatomic,copy) ActionHandler actHandler;
@property (nonatomic,assign) NSInteger backNum;
@end

@implementation UITableView (IndexView)
-(void)setIndexViewWithSize:(CGSize)size itemCount:(NSInteger)itemCount  layoutHandler:(void(^)(UIView *indexView,NSArray<UIView*>* items))layoutHandler actionHandler:(void(^)(NSInteger index))actionHandler{
    
    self.actHandler = actionHandler;
    [self.backView removeFromSuperview];
    self.currentIndex = 0;
//    self.backNum = 0;
    self.itemArray = [NSMutableArray array];
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.frame) + (CGRectGetWidth(self.frame) - size.width), CGRectGetMinY(self.frame) + (CGRectGetHeight(self.frame)-size.height)/2, size.width, size.height)];
//    self.backView.maxX = self.maxX;
//    self.backView.midY = self.midY;
    [self.superview addSubview:self.backView];
    
    CGFloat itemWith = size.width;
    CGFloat itemHeight = size.height / itemCount;
    for (int i = 0; i < itemCount; i ++) {
        UIView *item = [[UIView alloc]initWithFrame:CGRectMake(0, itemHeight * i, itemWith, itemHeight)];
        [self.backView addSubview:item];
        [self.itemArray addObject:item];
    }
    
    layoutHandler(self.backView,[self.itemArray copy]);
    
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(tapAct:)];
    tap.minimumPressDuration = .01;
    [self.backView addGestureRecognizer:tap];
        
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];

    actionHandler(0);
    
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{

    NSValue *pointValue = change[@"new"];
    CGPoint point = pointValue.CGPointValue;
    //        NSLog(@"%f",point.y);
    
    NSInteger nowSection = -1;
    NSIndexPath *indexPath = [self indexPathForRowAtPoint:CGPointMake(0, point.y - self.defaultContentOffSet)];
    nowSection = indexPath.section;

    //        NSLog(@"%ld--%ld",nowSection,self.currentIndex);
    if (self.currentIndex != nowSection) {
        self.currentIndex = nowSection;
        self.actHandler(nowSection);
    }
            
            
    if (self.backNum == 1) {
        self.defaultContentOffSet = self.contentOffset.y;
    }
    self.backNum++;
    
}

-(void)tapAct:(UIGestureRecognizer*)ges{

    CGPoint point = [ges locationInView:self.backView];
//    NSLog(@"%f",point.y);
    CGFloat itemHeight = CGRectGetHeight(self.backView.frame) / self.backView.subviews.count;
    NSInteger index = point.y / itemHeight;
    if (index >= 0 && index < self.numberOfSections ) {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    
}

static UIView *backView_id = nil;
-(void)setBackView:(UIView *)backView{
    objc_setAssociatedObject(self, &backView_id, backView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIView*)backView{
    return objc_getAssociatedObject(self, &backView_id);
}
static NSMutableArray *itemArray_id = nil;
-(void)setItemArray:(NSMutableArray *)itemArray{
    objc_setAssociatedObject(self, &itemArray_id, itemArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSMutableArray*)itemArray{
    return objc_getAssociatedObject(self, &itemArray_id);
}
static NSString *currentIndex_id = nil;
-(void)setCurrentIndex:(NSInteger)currentIndex{
    objc_setAssociatedObject(self, &currentIndex_id, [NSString stringWithFormat:@"%ld",(long)currentIndex], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSInteger)currentIndex{
    return [objc_getAssociatedObject(self, &currentIndex_id)integerValue];
}
static NSString *defaultContentOffSet_id = nil;
-(void)setDefaultContentOffSet:(CGFloat)defaultContentOffSet{
    objc_setAssociatedObject(self, &defaultContentOffSet_id, [NSString stringWithFormat:@"%f",defaultContentOffSet], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(CGFloat)defaultContentOffSet{
    return [objc_getAssociatedObject(self, &defaultContentOffSet_id) floatValue];
}
static NSString *actHandler_id = nil;
-(void)setActHandler:(ActionHandler)actHandler{
    objc_setAssociatedObject(self, &actHandler_id, actHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(ActionHandler)actHandler{
    return objc_getAssociatedObject(self, &actHandler_id);
}
static NSString *backNum_id = nil;
-(void)setBackNum:(NSInteger)backNum{
    objc_setAssociatedObject(self, &backNum_id, [NSString stringWithFormat:@"%ld",(long)backNum], OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSInteger)backNum{
    return [objc_getAssociatedObject(self, &backNum_id)integerValue];
}
@end
