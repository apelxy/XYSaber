//
//  XYAppInfo.m
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "XYApp.h"
@implementation XYApp

+(NSString*)version{
    return [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+(NSString*)bundleId{
    return [[[NSBundle mainBundle]infoDictionary] objectForKey:@"CFBundleIdentifier"];
}

+(BOOL)statusBarHidden{
    CGRect statusBarFrame = [UIApplication sharedApplication].statusBarFrame;
    return CGRectEqualToRect(statusBarFrame, CGRectZero);
}

+(UIView*)firstResponder{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    UIView *firstResponder = [keyWindow performSelector:@selector(firstResponder)];
    return firstResponder;
}

+(UIViewController*)currentViewController{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    if (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

+(NSDictionary*)infoDictionary{
    return [[NSBundle mainBundle]infoDictionary];
}

+(NSString *)cachesPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *caches = [paths firstObject];
    return caches;
}
+(NSString *)documentPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths firstObject];
    return documentPath;
}
+(NSString *)libraryPath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [paths firstObject];
    return documentPath;
}
@end
