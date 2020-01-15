//
//  UIImageView+XY.h
//  XYUserTool
//
//  Created by lxy on 2019/1/11.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (XY)

//网络图片加载
-(void)xy_setImageWithUrl:(NSString*)url placeHolderImage:(UIImage*)placeHolderImage;
//加载视频缩略图
-(void)xy_setImageWithLocalVideo:(NSString*)videoPath placeHolderImage:(UIImage*)placeHolderImage;
+(void)cleanXYImageCache;

//图片扩展点击事件
-(void)xy_addActionExtend:(UIEdgeInsets)actionExtend action:(void(^)(void))action;

@end


