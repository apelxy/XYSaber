//
//  XYNet.h
//  XYUserTool5
//
//  Created by lxy on 2018/12/26.
//  Copyright © 2018年 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XYNet : NSObject

@property (nonatomic,assign) NSInteger retryCount;

-(void)requestWithURL:(NSString*)url parameters:(id)parameters headers:(NSDictionary*)headers success:(void (^)(NSURLResponse *response, NSData *data))success failure:(void (^)(NSError *error))failure;


@end


