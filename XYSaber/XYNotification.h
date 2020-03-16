//
//  XYNotification.h
//  XYKit
//
//  Created by lxy on 2019/10/10.
//  Copyright © 2019 lxy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XYNotification : NSObject
+(void)showNotificationWithTitle:(NSString *)title subtitle:(NSString*)subtitle body:(NSString*)body badge:(int)badge;
-(instancetype)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle body:(NSString*)body badge:(int)badge triggerTimeInterval:(NSTimeInterval)triggerTimeInterval;
-(void)startWithHandler:(void(^)(NSError *error))handler;
@end

