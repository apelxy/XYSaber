//
//  TimerTool.h
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYTimer : NSObject

-(instancetype)initWithEndTime:(NSInteger)endTime;
-(void)startWithHandler:(void(^)(NSInteger time))handler;
-(void)pause;
-(void)stop;
-(void)restart;

@end


