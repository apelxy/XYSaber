//
//  UITableViewCell+XY.h
//  XYUserTool
//
//  Created by lxy on 2019/1/11.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^XYTableViewCellTransBlock)(id parameter);

@interface UITableViewCell (XY)
@property (nonatomic,copy) XYTableViewCellTransBlock dataBlock;
@property (nonatomic,copy) XYTableViewCellTransBlock backBlock;
@property (nonatomic,assign) CGFloat width;
@property (nonatomic,assign) CGFloat height;

-(void)xy_addLeftSwipeWithView:(UIView*)diyView cellWidth:(CGFloat)cellWidth cellHeight:(CGFloat)cellHeight;
-(void)xy_removeLeftSwipe;

@end


