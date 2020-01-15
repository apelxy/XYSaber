//
//  NSThread+XY.m
//  XYUserTool
//
//  Created by lxy on 2019/1/11.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import "NSThread+XY.h"
#import <objc/runtime.h>

@interface NSThread ()
//@property (nonatomic,strong) XYThreadSupport *threadSupport;

@end

@implementation NSThread (XY)

+(void)xy_creatDelayMainOperationWithTime:(NSInteger)time delayHandler:(void(^)(void))delayHandler{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:time];
        dispatch_async(dispatch_get_main_queue(), ^{
            delayHandler();
        });
    });
}
+(void)xy_creatDelayOperationWithTime:(NSInteger)time delayHandler:(void(^)(void))delayHandler{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSThread sleepForTimeInterval:time];
        delayHandler();
    });
}
+(void)xy_createGlobalThread:(id(^)(void))globalHandler backToMainThread:(void(^)(id obj))mainHandler{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        id obj = globalHandler();
        dispatch_async(dispatch_get_main_queue(), ^{
            mainHandler(obj);
        });
    });
}
+(void)xy_createGlobalThread:(void(^)(void))globalHandler{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        globalHandler();
    });
}
+(void)xy_backToMainThread:(void(^)(void))mainHandler{
    dispatch_async(dispatch_get_main_queue(), ^{
        mainHandler();
    });
}


@end
