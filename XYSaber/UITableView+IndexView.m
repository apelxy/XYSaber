//
//  UITableView+Index.m
//  XYKitDemo
//
//  Created by lxy on 2019/12/23.
//  Copyright © 2019 lxy. All rights reserved.
//

#import "UITableView+IndexView.h"
#import <objc/runtime.h>
#import "UIView+XY.h"
#import "NSObject+XY.h"
typedef void(^ActionHandler)(NSInteger index);

@interface UITableView ()
@property (nonatomic,strong) UIView *backView;
@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation UITableView (IndexView)
-(void)setIndexViewWithSize:(CGSize)size itemCount:(NSInteger)itemCount  layoutHandler:(void(^)(UIView *indexView,NSArray<UIView*>* items))layoutHandler actionHandler:(void(^)(NSInteger index))actionHandler{
    self.itemArray = [NSMutableArray array];
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    self.backView.maxX = self.maxX;
    self.backView.midY = self.midY;
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
    

    [self xy_addObserveWithKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil handler:^(id  _Nonnull value, void * _Nullable context) {
        NSValue *pointValue = value;
        CGPoint point = pointValue.CGPointValue;
//        NSLog(@"%f",point.y);
        
        NSInteger nowSection = -1;
        NSIndexPath *indexPath = [self indexPathForRowAtPoint:CGPointMake(0, point.y+20)];
        nowSection = indexPath.section;

//        NSLog(@"%ld--%ld",nowSection,self.currentIndex);
        if (self.currentIndex != nowSection) {
            self.currentIndex = nowSection;
            actionHandler(nowSection);
        }
        
    }];
    actionHandler(0);
}
-(void)tapAct:(UIGestureRecognizer*)ges{

    CGPoint point = [ges locationInView:self.backView];
//    NSLog(@"%f",point.y);
    CGFloat itemHeight = self.backView.height / self.backView.subviews.count;
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
@end
