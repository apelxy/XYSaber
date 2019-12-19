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

@property (nonatomic,copy,readonly,class) NSString *version;
@property (nonatomic,copy,readonly,class) NSString *bundleId;
@property (nonatomic,copy,readonly,class) UIViewController *currentViewController;
@property (nonatomic,assign,readonly,class) BOOL statusBarHidden;
@property (nonatomic,strong,readonly,class) UIView *firstResponder;
@property (nonatomic,strong,readonly,class) NSDictionary *infoDictionary;

@property (nonatomic,readonly,class,copy) NSString *cachesPath;
@property (nonatomic,readonly,class,copy) NSString *documentPath;
@property (nonatomic,readonly,class,copy) NSString *libraryPath;

@end


