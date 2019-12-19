//
//  XYTabBarController.h
//  XYUserKit
//
//  Created by lxy on 2019/1/15.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYTabBarItem : UIButton

@end

@interface XYTabBarController : UIViewController
@property (nonatomic,strong) NSArray* viewControllers;

@property (nonatomic,strong) NSArray *images;
@property (nonatomic,strong) NSArray *selectedImages;

@property (nonatomic,strong) NSArray* titles;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIColor *selectedTitleColor;

@property (nonatomic,strong) UIView *tabBar;

@property (nonatomic,copy) void(^diyItemBlock)(NSArray<XYTabBarItem*> *itemArray,NSInteger index);

@property (nonatomic,assign) NSInteger selectedIndex;

@end


