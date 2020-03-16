//
//  XYNotification.m
//  XYKit
//
//  Created by lxy on 2019/10/10.
//  Copyright © 2019 lxy. All rights reserved.
//

#import "XYNotification.h"
#import <UserNotifications/UserNotifications.h>

@interface XYNotification ()
@property (nonatomic,strong) UNNotificationRequest *request;
@end

@implementation XYNotification

-(instancetype)initWithTitle:(NSString*)title subtitle:(NSString*)subtitle body:(NSString*)body badge:(int)badge triggerTimeInterval:(NSTimeInterval)triggerTimeInterval{
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
     content.badge = @(badge);
     content.title = title;
     content.subtitle = subtitle;
     content.body = body;
     
     UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:triggerTimeInterval repeats:NO];
     _request = [UNNotificationRequest requestWithIdentifier:[NSString stringWithFormat:@"%@-%@-%@-%d",title,subtitle,body,badge] content:content trigger:trigger];
    
     // 需要将声音提示框等进行注册
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
    }];
    return self;
}
-(void)startWithHandler:(void(^)(NSError * _Nullable error))handler{
    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:_request withCompletionHandler:^(NSError * _Nullable error) {
        
    }];
}

+(void)showNotificationWithTitle:(NSString*)title subtitle:(NSString*)subtitle body:(NSString*)body badge:(int)badge{
    XYNotification *notification = [[XYNotification alloc]initWithTitle:title subtitle:subtitle body:body badge:badge triggerTimeInterval:.1];
    [notification startWithHandler:nil];
    
    
}
@end
