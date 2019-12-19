//
//  UIButton+XY.h
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIButton (XY)

@property (nonatomic,copy) NSString *title;
@property (nonatomic,strong) UIColor *titleColor;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImage *backgroundImage;

@property (nonatomic,copy) void(^action)(UIButton *button);


-(void)xy_contentFitToWith;

@end


