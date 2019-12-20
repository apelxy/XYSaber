//
//  XYNet.m
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import "XYNet.h"

@interface XYNet ()
@property (nonatomic,assign) NSInteger count;
@end

@implementation XYNet
-(void)requestWithURL:(NSString*)url parameters:(id)parameters headers:(NSDictionary*)headers completionHandler:(void (^)(NSURLResponse *response, NSData *data, NSError *error))completionHandler{

    NSURL *urlStr = [NSURL URLWithString:url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:urlStr];
    
    //设置request
    if (parameters) {
        if ([parameters isKindOfClass:[NSDictionary class]]) {  //字典类型
            request.HTTPBody = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:nil];
        }else if ([parameters isKindOfClass:[NSString class]]){ //字符串类型
            request.HTTPBody = [parameters dataUsingEncoding:NSUTF8StringEncoding];
        }else if([parameters isKindOfClass:[NSData class]]){
            request.HTTPBody = parameters;
        }
        request.HTTPMethod = @"POST";
    }else{
        request.HTTPMethod = @"GET";
    }
    
    //设置headers
    NSArray *headersAllKeys = headers.allValues;
    for (NSString *key in headersAllKeys) {
        NSString *value = headers[key];
        [request addValue:value forHTTPHeaderField:key];
    }

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.count++;
                if (error && self.count < self.retryCount) {
                    [self requestWithURL:url parameters:parameters headers:headers completionHandler:completionHandler];
                }else{
                    completionHandler(response,data,error);
                }
            });
        }];
        [dataTask resume];
    });
}


@end
