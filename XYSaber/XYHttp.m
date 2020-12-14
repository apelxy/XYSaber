//
//  XYNet.m
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "XYHttp.h"

@implementation XYHttp
+ (void)requestWithURL:(NSString*)url parameters:(id)parameters headers:(NSDictionary*)headers retryCount:(int)retryCount success:(void (^)(NSURLResponse *response, NSData *data))success failure:(void (^)(NSError *error))failure{
    
    NSLog(@"请求URL:%@",url);
    NSURL *urlStr = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlStr];
    
    //设置request
    NSString *reqJson = @"";
    if (parameters) {
        if ([parameters isKindOfClass:[NSDictionary class]]) {  //字典类型
            NSData *reqData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
            request.HTTPBody = reqData;
            reqJson = [[NSString alloc]initWithData:reqData encoding:NSUTF8StringEncoding];
            
        }else if ([parameters isKindOfClass:[NSString class]]){ //字符串类型
            request.HTTPBody = [parameters dataUsingEncoding:NSUTF8StringEncoding];
            reqJson = parameters;
        }else if([parameters isKindOfClass:[NSData class]]){
            request.HTTPBody = parameters;
            reqJson = [[NSString alloc]initWithData:parameters encoding:NSUTF8StringEncoding];
        }
        request.HTTPMethod = @"POST";
//        NSLog(@"请求Json:%@",reqJson);
    }else{
        request.HTTPMethod = @"GET";
    }
    
    
    //设置headers
    NSArray *headersAllKeys = headers.allValues;
    for (NSString *key in headersAllKeys) {
        NSString *value = headers[key];
        [request addValue:value forHTTPHeaderField:key];
    }
    
    
    //开始请求
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self goRequest:request retryCount:retryCount retryIndex:0 success:success failure:failure];
    });
}

+ (void)goRequest:(NSMutableURLRequest *)request retryCount:(int)retryCount retryIndex:(int)retryIndex success:(void (^)(NSURLResponse *response,  NSData *data))success failure:(void (^)(NSError *error))failure{
    retryIndex++;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
            if (error) {
                NSLog(@"请求错误");
                if (retryIndex >= retryCount) {
                    failure(error);
//                    [[UIApplication sharedApplication].keyWindow xy_showMsg:@"网络错误！" endTime:2];
                }else{
                    [self goRequest:request retryCount:retryCount retryIndex:retryIndex success:success failure:failure];
                }
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(response,data);
                });
                
            }
        
    }];
    [dataTask resume];
}

@end
