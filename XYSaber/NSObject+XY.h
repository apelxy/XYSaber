//
//  NSObject+XY.h
//  XYUserTool
//
//  Created by lxy on 2019/1/10.
//  Copyright © 2019年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (XY)

@property (nonatomic,strong,readonly) NSDictionary *xy_properties;

+(instancetype)xy_objectWithDictionary:(NSDictionary*)aDictionary;
+(instancetype)xy_objectWithDictionary:(NSDictionary*)aDictionary map:(NSDictionary*)map;

-(void)xy_addObserveWithName:(NSString*)name activate:(void(^)(NSNotification *notification))activate;

-(void)xy_addObserveWithKeyPath:(NSString*)keyPath options:(NSKeyValueObservingOptions)options context:(nullable void *)context handler:(void(^)(id value,void * _Nullable context))handler;

@end

NS_ASSUME_NONNULL_END
