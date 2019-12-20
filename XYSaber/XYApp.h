//
//  XYAppInfo.h
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XYApp : NSObject

@property (nonatomic,class,readonly,copy) NSString *version;
@property (nonatomic,class,readonly,copy) NSString *bundleId;
@property (nonatomic,class,readonly,copy) UIViewController *currentViewController;
@property (nonatomic,class,readonly,assign) BOOL statusBarHidden;
@property (nonatomic,class,readonly,strong) UIView *firstResponder;
@property (nonatomic,class,readonly,strong) NSDictionary *infoDictionary;

@property (nonatomic,class,readonly,copy) NSString *cachesPath;
@property (nonatomic,class,readonly,copy) NSString *documentPath;
@property (nonatomic,class,readonly,copy) NSString *libraryPath;

@end


