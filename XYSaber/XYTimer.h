//
//  TimerTool.h
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYTimer : NSObject

-(void)startWithTimeInterval:(NSTimeInterval)timeInterval handler:(void(^)(void))handler;
-(void)pause;
-(void)stop;
-(void)restart;

+(void)countdownWithTotalTime:(NSTimeInterval)totalTime timeInterval:(NSTimeInterval)timeInterval handler:(void(^)(NSTimeInterval time))handler;

@end


