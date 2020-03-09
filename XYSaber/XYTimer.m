//
//  TimerTool.m
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "XYTimer.h"

#import "XYMacro.h"
@interface XYTimer ()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,assign) NSTimeInterval timeInterval;
@property (nonatomic,copy) void(^handler)(void);
@end

@implementation XYTimer

-(void)startWithTimeInterval:(NSTimeInterval)timeInterval handler:(void(^)(void))handler{
    self.handler = handler;
    self.timeInterval = timeInterval;
    [self start];
}
-(void)timerAct{
    self.handler();
}
-(void)start{
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:self.timeInterval target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
    }else{
        [self.timer setFireDate:[NSDate date]];
    }
    
}
-(void)pause{
    [self.timer setFireDate:[NSDate distantFuture]];
}
-(void)stop{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)restart{
    [self stop];
    [self start];
}
-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}

+(void)countdownWithTotalTime:(NSTimeInterval)totalTime timeInterval:(NSTimeInterval)timeInterval handler:(void(^)(NSTimeInterval time))handler{
    __block NSTimeInterval currentTime = totalTime;
    XYTimer *timer = [[XYTimer alloc]init];
    [timer startWithTimeInterval:timeInterval handler:^{
        currentTime = currentTime - timeInterval;
        handler(currentTime >= 0?currentTime:0);
        if (currentTime <= 0) {
            [timer stop];
        }
    }];
}

@end
