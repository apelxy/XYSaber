//
//  XYNet.h
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XYHttp : NSObject

+ (void)requestWithURL:(NSString*)url parameters:(id)parameters headers:(NSDictionary*)headers retryCount:(int)retryCount success:(void (^)(NSURLResponse *response, NSData *data))success failure:(void (^)(NSError *error))failure;


@end


