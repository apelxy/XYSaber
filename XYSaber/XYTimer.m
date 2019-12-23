//
//  TimerTool.m
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "XYTimer.h"
#import "XYHeader.h"
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
        setWeakSelf
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            
            self.currentTime++;
            if(weakSelf.endtime && weakSelf.currentTime >= weakSelf.endtime){
                weakSelf.currentTime = -1;
                [weakSelf stop];
            }
//            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(xyTimer_time:)]){
//                [weakSelf.delegate xyTimer_time:weakSelf.currentTime];
//            }
            weakSelf.handler(weakSelf.currentTime);
            
        }];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
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
