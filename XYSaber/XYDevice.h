//
//  XYDeviceInfo.h
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
@interface XYDevice : NSObject
@property (nonatomic,class,readonly,assign) CGFloat screenWidth;
@property (nonatomic,class,readonly,assign) CGFloat screenHeight;
@property (nonatomic,class,readonly,assign) CGFloat safeAreaInsetsTop;
@property (nonatomic,class,readonly,assign) CGFloat safeAreaInsetsBottom;
@property (nonatomic,class,readonly,assign) BOOL isX;


@end


