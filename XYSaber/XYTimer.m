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
@property (nonatomic,assign) NSInteger currentTime;
@property (nonatomic,assign) NSInteger endtime;
@property (nonatomic,copy) void(^handler)(NSInteger time);
@end

@implementation XYTimer
-(instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}
-(void)startWithHandler:(void(^)(NSInteger time))handler{
    self.handler = handler;
    [self start];
}
-(void)start{
    if (!self.timer) {
        self.currentTime = 0;

        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerAct) userInfo:nil repeats:YES];
//        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }else{
        [self.timer setFireDate:[NSDate date]];
    }
}
-(void)timerAct{
    self.currentTime++;
    if(self.endtime && self.currentTime >= self.endtime){
        self.currentTime = -1;
        [self stop];
    }
    
    self.handler(self.currentTime);
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

-(instancetype)initWithEndTime:(NSInteger)endTime{
    self = [super init];
    if (self) {
        
        _endtime = endTime;
    }
    return self;
}


-(void)dealloc{
    [self.timer invalidate];
    self.timer = nil;
}
@end
