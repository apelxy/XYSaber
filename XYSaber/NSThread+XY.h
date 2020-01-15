//
//  NSThread+XY.h
//  XYUserTool
//
//  Created by lxy on 2019/1/11.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>

//typedef void(^XYThreadDelayBlock)(void);


@interface NSThread (XY)

+(void)xy_creatDelayMainOperationWithTime:(NSInteger)time delayHandler:(void(^)(void))delayHandler;
+(void)xy_creatDelayOperationWithTime:(NSInteger)time delayHandler:(void(^)(void))delayHandler;

+(void)xy_createGlobalThread:(id (^)(void))globalHandler backToMainThread:(void(^)(id obj))mainHandler;
+(void)xy_createGlobalThread:(void(^)(void))globalHandler;
+(void)xy_backToMainThread:(void(^)(void))mainHandler;



@end


