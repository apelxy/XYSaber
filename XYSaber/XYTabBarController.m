//
//  XYTabBarController.m
//  XYUserKit
//
//  Created by lxy on 2019/1/15.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "XYTabBarController.h"
#import "UIView+XY.h"
#import "UIButton+XY.h"
#import "XYDevice.h"
#import "XYMacro.h"
#import "UIColor+XY.h"
#import "XYMasonry.h"

@interface XYTabBarItem ()
@property (nonatomic, strong) UIImageView *imgv;
@property (nonatomic, strong) UILabel *label;
@end

@implementation XYTabBarItem

- (instancetype)init{
    self = [XYTabBarItem buttonWithType:UIButtonTypeCustom];
    if (self) {
        
        [self addSubview:self.imgv];
        [self addSubview:self.label];
        
    }
    return self;
}
- (void)layoutSubviews{
    [self.imgv mas_makeConstraints:^(XYMASConstraintMaker *make) {
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
        make.top.mas_equalTo(5);
        make.centerX.equalTo(self.mas_centerX);
    }];
    
    [self.label mas_makeConstraints:^(XYMASConstraintMaker *make) {
        make.width.equalTo(self.mas_width);
        make.height.mas_equalTo(4);
        make.top.mas_equalTo(37);
        make.centerX.equalTo(self.mas_centerX);
    }];
}
- (UIImageView *)imgv{
    if (!_imgv) {
        _imgv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
        _imgv.midX = self.width / 2;
        
    }
    return _imgv;
}
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, _imgv.maxY + 2, self.width, self.height - _imgv.maxY - 4)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:_label.height - .5];
        
    }
    return _label;
}
@end

@interface XYTabBarController ()
@property (nonatomic,strong) NSMutableArray *itemArray;
@property (nonatomic,strong) NSMutableArray *titleLabelArray;
@property (nonatomic,strong) NSMutableArray *imageArray;
@end

@implementation XYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.itemArray = [NSMutableArray array];
    self.titleLabelArray = [NSMutableArray array];
    self.imageArray = [NSMutableArray array];
    
    [self.view addSubview:self.tabBar];
    
    for (int i = 0; i < self.viewControllers.count; i++) {
        UIViewController *vc = self.viewControllers[i];
        [self addChildViewController:vc];
        [self.tabBar addSubview:[self getItemWithIndex:i]];
        
        //触发
        if (self.diyItemBlock) {
            self.diyItemBlock(self.itemArray, i);
        }
    }
    [self setSelectedItemWithIndex:0];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSArray *subViews = self.tabBar.subviews;
    for (UIView *view in subViews) {
        [self.tabBar bringSubviewToFront:view];
    }
}
- (UIView*)getItemWithIndex:(NSInteger)index{
    CGFloat itemWidth = self.tabBar.width / self.viewControllers.count;
    XYTabBarItem *item = [XYTabBarItem buttonWithType:UIButtonTypeCustom];
    item.frame = CGRectMake(itemWidth * index, 0, itemWidth, 49);
//    [item mas_makeConstraints:^(XYMASConstraintMaker *make) {
//        make.width.mas_equalTo(itemWidth);
//        make.height.mas_equalTo(49);
//        make.left.mas_equalTo(itemWidth * index);
//        make.top.mas_equalTo(0);
//    }];
    [self.tabBar addSubview:item];
    [self.itemArray addObject:item];
    item.action = ^(UIButton *button) {
        [self setSelectedItemWithIndex:index];
    };
    
    
//    imgV.backgroundColor = [UIColor grayColor];
    item.imgv.image = self.images[index];
    [item addSubview:item.imgv];
    [self.imageArray addObject:item.imgv];
    
    
    item.label.text = self.titles[index];
    [item addSubview:item.label];
    [self.titleLabelArray addObject:item.label];
    
    return item;
}
- (UIView*)tabBar{
    if (!_tabBar) {
        _tabBar = [[UIView alloc]initWithFrame:CGRectMake(0, xy_kHeight - 49, xy_kWidth, 49)];
        if (XYDevice.isX) {
            _tabBar.y = xy_kHeight - 49 - 34;
            _tabBar.height = 49+34;
        }
        _tabBar.backgroundColor = [UIColor whiteColor];
        
        //阴影
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, _tabBar.width, 0.5)];
        line.backgroundColor = [UIColor xy_hexColor:@"bbbbbb"];
        [_tabBar addSubview:line];
    }
    return _tabBar;
}
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [self setSelectedItemWithIndex:selectedIndex];
}
- (void)setSelectedItemWithIndex:(NSInteger)index{
    
    
    //切换控制器
    UIViewController *vc = self.viewControllers[index];
    [self.view addSubview:vc.view];
    [self.view bringSubviewToFront:self.tabBar];
    for (int i = 0; i < self.viewControllers.count; i++) {
        UIViewController *otherVC = self.viewControllers[i];
        if (i != index) {
            [otherVC.view removeFromSuperview];
        }
    }
    
    //切换文字颜色
    for (int i = 0; i < self.titleLabelArray.count; i++) {
        UILabel *lab = self.titleLabelArray[i];
        if (i == index) {
            lab.textColor = self.selectedTitleColor;
        }else{
            lab.textColor = self.titleColor;
        }
    }
    
    //切换图片
    for (int i = 0; i < self.imageArray.count; i++) {
        UIImageView *imgV = self.imageArray[i];
        if (i == index) {
            imgV.image = self.selectedImages[i];
        }else{
            imgV.image = self.images[i];
        }
    }
}

@end
