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


+(CGFloat)safeAreaInsetsTop{
    CGFloat top = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.top;
    return top;
}
+(CGFloat)safeAreaInsetsBottom{
    CGFloat a = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
    return a;
}
+(BOOL)isX{
    if (self.safeAreaInsetsBottom > 0) {
        return YES;
    }else{
        return NO;
    }
}
+(CGFloat)screenWidth{
    return [UIScreen mainScreen].bounds.size.width;
}
+(CGFloat)screenHeight{
    return [UIScreen mainScreen].bounds.size.height;
}
@end
