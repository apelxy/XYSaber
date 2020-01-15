//
//  NSObject+XY.m
//  XYUserTool
//
//  Created by lxy on 2019/1/10.
//  Copyright © 2019年 lxy. All rights reserved.
//



#import "NSObject+XY.h"
#import <objc/runtime.h>
#import "XYObjectSupport.h"

@interface NSObject ()
@property (nonatomic,strong) XYObjectSupport *objectSupport;
@end


static XYObjectSupport *objectSupport_id = nil;
@implementation NSObject (XY)

-(void)setObjectSupport:(XYObjectSupport *)objectSupport{
    objc_setAssociatedObject(self, &objectSupport_id, objectSupport, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(XYObjectSupport*)objectSupport{
    XYObjectSupport *support = objc_getAssociatedObject(self, &objectSupport_id);
    if (!support) {
        support = [[XYObjectSupport alloc]init];
        support.blockArray = [NSMutableArray array];
        support.observeArray = [NSMutableArray array];
        [self setObjectSupport:support];
    }
    return support;
}

//添加通知
-(void)xy_addObserveWithName:(NSString*)name activate:(XYNotificationBlock)activate{

    BOOL hasName = NO;
    for (int i = 0; i < self.objectSupport.blockArray.count; i++) {
        NSDictionary *dic = self.objectSupport.blockArray[i];
        NSString *oName = dic[@"name"];
        if ([name isEqualToString:oName]) {
            hasName = YES;
        }
    }
    if (!hasName) {
        [[NSNotificationCenter defaultCenter]addObserver:self.objectSupport selector:@selector(notificationActivate:) name:name object:nil];
    }
    
    NSDictionary *dic = @{
                          @"name":name,
                          @"block":activate
                          };
    [self.objectSupport.blockArray addObject:dic];
}



-(void)xy_addObserveWithKeyPath:(NSString*)keyPath options:(NSKeyValueObservingOptions)options handler:(XYObserveBlock)handler{
    
    BOOL hasKeyPath = NO;
    
    for (int i = 0; i < self.objectSupport.observeArray.count; i++) {
        NSDictionary *dic = self.objectSupport.observeArray[i];
        NSString *oName = dic[@"name"];
        if ([keyPath isEqualToString:oName]) {
            hasKeyPath = YES;
        }
    }
    
    if (!hasKeyPath) {
        [self addObserver:self.objectSupport forKeyPath:keyPath options:options context:nil];
    }
    
    NSDictionary *dic = @{
                          @"name":keyPath,
                          @"block":handler
                          };
    [self.objectSupport.observeArray addObject:dic];
}

//字典转model
+(instancetype)xy_objectWithDictionary:(NSDictionary*)aDictionary{
    id obj = [[self alloc]init];
    NSArray *propertys = [self getAllPropertysWithObject:obj].allKeys;
    NSArray *keys = aDictionary.allKeys;
    for (int i = 0; i < keys.count; i++) {
        NSString *key = keys[i];
        if ([propertys containsObject:key]) {
            [obj setValue:aDictionary[key] forKey:key];
        }
    }
    return obj;
}
+(instancetype)xy_objectWithDictionary:(NSDictionary*)aDictionary map:(NSDictionary*)map{
    NSMutableDictionary *mulDic = [NSMutableDictionary dictionary];
    NSArray *mapKeys = map.allKeys;
    for (int i = 0; i < mapKeys.count; i++) {
        NSString *modelProperty = mapKeys[i];
        NSString *key = [map objectForKey:modelProperty];
        if ([aDictionary.allKeys containsObject:key]) {
            [mulDic setObject:[aDictionary objectForKey:key] forKey:modelProperty];
        }
    }
    return [self xy_objectWithDictionary:[mulDic copy]];
}


#pragma mark 激活懒加载=======================================================
-(void)xy_lazyLoad{}

-(NSDictionary*)xy_properties{
    return [self getAllPropertysWithObject:self];
}
-(NSDictionary*)getAllPropertysWithObject:(id)object{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([object class], &outCount);
    for (i = 0; i<outCount; i++){
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [object valueForKey:(NSString *)propertyName];
        if (propertyValue){
            [props setObject:propertyValue forKey:propertyName];
        }else{
            [props setObject:[NSNull new] forKey:propertyName];
        }
     }
    free(properties);
    return props;
}


@end
