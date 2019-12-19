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

@property (nonatomic,assign) CGFloat safeAreaInsetsTop;
@property (nonatomic,assign) CGFloat safeAreaInsetsBottom;
@property (nonatomic,assign,readonly) BOOL isX;

+(instancetype)shared;
-(void)volumeMonitorNotificationHandler:(void(^)(NSNotification *notification))notificationHandler;
-(void)setVolumeView:(MPVolumeView*)volumeView;
@end


