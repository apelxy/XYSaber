//
//  XYDeviceInfo.m
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "XYDevice.h"
#import <AdSupport/AdSupport.h>
#import <AVKit/AVKit.h>

#import "NSObject+XY.h"

@interface XYDevice ()
@property (nonatomic,strong) AVAudioSession *audioSession;
@end

@implementation XYDevice

+(instancetype)shared{
    static XYDevice *info = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        info = [[XYDevice alloc]init];
    });
    return info;
}

-(AVAudioSession*)audioSession{
    if (!_audioSession) {
        _audioSession = [AVAudioSession sharedInstance];
        [_audioSession setActive:YES error:nil];
        [_audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        NSError *error;
        [[AVAudioSession sharedInstance] setActive:YES error:&error];
        //注，ios9上不加这一句会无效
        [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    }
    return _audioSession;
}

-(void)volumeMonitorNotificationHandler:(void(^)(NSNotification *notification))notificationHandler{
    
    [self.audioSession class];
    
    [self xy_addObserveWithName:@"AVSystemController_SystemVolumeDidChangeNotification" activate:^(NSNotification *notification) {
        notificationHandler(notification);
    }];
}

-(void)setVolumeView:(MPVolumeView*)volumeView{
    if (volumeView) {
        [[UIApplication sharedApplication].keyWindow addSubview:volumeView];
    }else{
        MPVolumeView *diyVolumeView = [[MPVolumeView alloc] initWithFrame:CGRectMake(0, 0, 200, 20)];
        diyVolumeView.center = CGPointMake(-550,370);//设置中心点，让音量视图不显示在屏幕中
        [diyVolumeView sizeToFit];
        [[UIApplication sharedApplication].keyWindow addSubview:diyVolumeView];
    }
}
-(CGFloat)safeAreaInsetsTop{
    CGFloat top = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.top;
    return top;
}
-(CGFloat)safeAreaInsetsBottom{
    CGFloat a = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
    return a;
}
-(BOOL)isX{
    if (self.safeAreaInsetsBottom > 0) {
        return YES;
    }else{
        return NO;
    }
    
}
@end
