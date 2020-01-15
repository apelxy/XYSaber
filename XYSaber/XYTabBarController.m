//
//  XYTabBarController.m
//  XYUserKit
//
//  Created by lxy on 2019/1/15.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "XYTabBarController.h"
#import "UIButton+XY.h"
#import "XYMacro.h"
#import "UIView+XY.h"
#import "UIColor+XY.h"
#import "XYDevice.h"
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
    }
    [self setSelectedItemWithIndex:0];
}
-(UIView*)getItemWithIndex:(NSInteger)index{
    CGFloat itemWidth = self.tabBar.width / self.viewControllers.count;
    UIButton *item = [UIButton buttonWithType:UIButtonTypeCustom];
    item.frame = CGRectMake(itemWidth * index, 0, itemWidth, 49);
    [self.tabBar addSubview:item];
    [self.itemArray addObject:item];
    item.action = ^(UIButton *button) {
        [self setSelectedItemWithIndex:index];
    };
    
    UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 30, 30)];
    imgV.midX = item.width / 2;
//    imgV.backgroundColor = [UIColor grayColor];
    imgV.image = self.images[index];
    [item addSubview:imgV];
    [self.imageArray addObject:imgV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imgV.maxY + 2, item.width, item.height - imgV.maxY - 4)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:label.height - .5];
    label.text = self.titles[index];
    [item addSubview:label];
    [self.titleLabelArray addObject:label];
    
    return item;
}
-(UIView*)tabBar{
    if (!_tabBar) {
        _tabBar = [[UIView alloc]initWithFrame:CGRectMake(0, XYDevice.screenHeight - 49, XYDevice.screenWidth, 49)];
        if (XYDevice.isX) {
            _tabBar.y = XYDevice.screenHeight - 49 - 34;
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
-(void)setSelectedIndex:(NSInteger)selectedIndex{
    _selectedIndex = selectedIndex;
    [self setSelectedItemWithIndex:selectedIndex];
}
-(void)setSelectedItemWithIndex:(NSInteger)index{
    //触发
    if (self.diyItemBlock) {
        self.diyItemBlock(self.itemArray, index);
    }
    
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
