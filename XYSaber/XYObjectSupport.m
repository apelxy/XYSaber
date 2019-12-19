//
//  XYObjectSupport.m
//  XYKit
//
//  Created by ios on 2019/4/23.
//  Copyright © 2019 lxy. All rights reserved.
//

#import "XYObjectSupport.h"

@implementation XYObjectSupport
-(void)notificationActivate:(NSNotification*)no{
    
    NSString *name = no.name;
    for (int i = 0; i < self.blockArray.count; i++) {
        NSString *na = self.blockArray[i][@"name"];
        if ([name isEqualToString:na]) {
            XYNotificationBlock bl = self.blockArray[i][@"block"];
            bl(no);
        }
    }
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    
    for (int i = 0; i < self.observeArray.count; i++) {
        NSString *na = self.observeArray[i][@"name"];
        if ([keyPath isEqualToString:na]) {
            XYObserveBlock bl = self.observeArray[i][@"block"];
            bl(change[@"new"],context);
        }
    }
}
@end
